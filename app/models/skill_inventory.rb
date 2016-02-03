require 'yaml/store'
require_relative 'skill'

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
    database.transaction do
      database['skills'] || []
    end
  end

  def all
    raw_skills.map { |data| Skill.new(data) }
  end

  def raw_skill(id)
    raw_skills.find { |skill| skill['id'] == id }
  end

  def find(id)
    Skill.new(raw_skill(id))
  end

  def update(skill, id)
    database.transaction do
      target = database['skills'].find { |data| data['id'] == id }
      target['name'] = skill['name']
      target['description'] = skill['description']
    end
  end

  def delete(id)
    database.transaction do
      database['skills'].delete_if { |data| data['id'] == id }
    end
  end
  # def self.database
  #   @database ||= YAML::Store.new("db/skill_inventory")
  # end
end
