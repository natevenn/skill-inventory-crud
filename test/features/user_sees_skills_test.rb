require_relative '../test_helper'

class UserSeesAllSkillsTest < FeatureTest
  include TestHelpers

  def create_skills(num)
    num.times do |i|
      skill_inventory.create({
        name:        "name#{i+1}",
        description: "description#{i+1}"
        })
      end
    end

    def test_a_user_can_see_a_single_skill
      create_skills(1)
      skill = skill_inventory.all.last

      visit '/skills'

      click_link("name1")
      assert_equal "/skills/#{skill.id}", current_path
      assert page.has_content?('description1')
    end

  def test_filter_task_index_by_param
    create_skills(1)

    skill_inventory.create({
      name:         "bilingual",
      description:  "English and Czech"
      })

    skill_inventory.create({
      name:        "bilingual",
      description: "English and Czech"
      })
      visit '/skills?name=bilingual'
      skill = skill_inventory.all.first
      selected_skills = skill_inventory.all.select { |skill| skill.name == "bilingual"}

    selected_skills.each do |skill|
      within("#skill-#{skill.id}") do
        assert page.has_content?("bilingual")
      end
    end
    refute page.has_content?("name#{skill.id}")
  end
end
