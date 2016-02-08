ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/erb'
require 'capybara/DSL'
require 'database_cleaner'

DatabaseCleaner[:sequel, {:connection => Sequel.sqlite("db/skill_inventory_test.sqlite3")}].strategy = :truncation


module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def skill_inventory
    database = Sequel.sqlite('db/skill_inventory_test.sqlite3')
    @skill_inventory ||= SkillInventory.new(database)
  end
end

Capybara.app = SkillInventoryApp
Capybara.save_and_open_page_path = 'tmp/capybara'

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
