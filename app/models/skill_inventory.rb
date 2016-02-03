require 'yaml/store'

class SkillInventory
attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(skill)
    database.transaction do
    database['skills'] ||= []
    database['total']  ||= 0
    database['total'] += 1
    database['skills'] << {'id'=> database['total'], 'name'=> skill[:name], 'description'=> skill[:description] }
    end
  end

  def raw_skills
    self
    database.transaction do
      database['skills'] || []
    end
  end

  def all
    raw_skills.map { |data| Skill.new(data) }
  end

  # def self.database
  #   @database ||= YAML::Store.new("db/skill_inventory")
  # end
end
