require 'rack/test'
require 'rspec'
require 'capybara'
require 'capybara/dsl'
ENV['RACK_ENV'] = 'test'
require_relative '../../server'
require 'selenium/webdriver'
require 'webdrivers'

RSpec.describe Server do
  include Capybara::DSL
  before do
    Capybara.app = Server.new
    Capybara.server = :webrick
  end

  after do
    Server.clear_game
  end

  it 'is possible to join a game' do
    visit '/'
    fill_in :name, with: 'John'
    click_on 'Login'
    expect(page).to have_content('Game')
    expect(page).to have_content('John')
  end

  it 'allows multiple players to join a game' do
    session1 = Capybara::Session.new(:rack_test, Server.new)
    session2 = Capybara::Session.new(:rack_test, Server.new) 
    
    [session1, session2].each_with_index do |session, index|
      player_name = "Player #{index + 1}"
      session.visit '/'
      session.fill_in :name, with: player_name
      session.click_on 'Login'
      expect(session).to have_content('Game')
      expect(session).to have_css('b', text: player_name)
    end
    expect(session2).to have_content('Player 1')
    session1.driver.refresh
    expect(session1).to have_content('Player 2')
  end

  # it 'uses JS to auto update the page', :js do
  #   session1 = Capybara::Session.new(:selenium_chrome_headless, Server.new)
  #   session2 = Capybara::Session.new(:selenium_chrome_headless, Server.new)

  #   [ session1, session2 ].each_with_index do |session, index|
  #     player_name = "Player #{index + 1}"
  #     session.visit '/'
  #     session.fill_in :name, with: player_name
  #     session.click_on 'Login'
  #     expect(session).to have_content('Game')
  #     expect(session).to have_content(player_name)
  #   end
  #   expect(session2).to have_content('Player 1')
  #   expect(session1).to have_content('Player 2')
  # end

  # it 'receives a player and outputs the popup' do
  #   session1 = Capybara::Session.new(:selenium_chrome_headless, Server.new)
  #   session2 = Capybara::Session.new(:selenium_chrome_headless, Server.new)

  #   [ session1, session2 ].each_with_index do |session, index|
  #     player_name = "Player #{index + 1}"
  #     session.visit '/'
  #     session.fill_in :name, with: player_name
  #     session.click_on 'Login'
  #     expect(session).to have_content('Game')
  #     expect(session).to have_content("Your Turn")
  #   end
  # end
end