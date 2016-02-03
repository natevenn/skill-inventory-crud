require 'models/skill_inventory'
class SkillInventoryApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    erb :dashboard
  end

  get '/skills' do
    @skills = skill_inventory.all
    erb :index
  end

  get '/skills/new' do
    erb :new
  end

  post '/skills' do
    skill_inventory.create(params[:skill])
    redirect '/skills'
  end

  def skill_inventory
    database = YAML::Store.new("db/skill_inventory")
    @skill_inventory ||= SkillInventory.new(database)
  end
end
