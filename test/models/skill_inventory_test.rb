require_relative '../test_helper'

class SkillInventoryTest < Minitest::Test
  include TestHelpers
  # include TestHelpers; include Capybara::DSL

  def create_skills(num)
    num.times do |i|
      skill_inventory.create(
        name:       "name#{i+1}",
        description: "description#{i+1}"
      )
    end
  end

  def test_can_create_a_task
    skill_inventory.create(
      name:        "name1",
      description: "description1"
    )

    skill = skill_inventory.all.last

    assert skill.id
    assert_equal "name1", skill.name
    assert_equal "description1", skill.description
  end

  def test_it_finds_a_specifi_task
    create_skills(3)
    ids = skill_inventory.all.map { |skill| skill.id }

    ids.each_with_index do |id, index|
      skill = skill_inventory.find(id)
      assert_equal "name#{index+1}", skill.name
      assert_equal "description#{index+1}", skill.description
    end
  end

  def test_it_updates_a_task_record
    create_skills(3)

    new_data = {
      :name => "NEW name",
      :description => "NEW description"
    }
    id = skill_inventory.all.last.id

    skill_inventory.update(new_data, id)

    updated_skill = skill_inventory.find(id)

    assert_equal new_data[:name], updated_skill.name
    assert_equal new_data[:description], updated_skill.description
  end

  def test_it_deletes_a_task_record
    create_skills(3)

    initial_count = skill_inventory.all.count
    id = skill_inventory.all.first.id
    skill_inventory.delete(id)

    final_count = skill_inventory.all.count

    assert_equal 1, (initial_count - final_count)
  end
end
