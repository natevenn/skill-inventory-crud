require_relative '../test_helper'

class UserUpdatesSkillTest < FeatureTest
  # include Capybara::DSL
  # include TestHelpers

  def test_existing_skill_is_updated_with_new_name_and_description
    skill_inventory.create({name: 'new name',
                            description: 'new description'})

    skill = skill_inventory.all.first
    visit "/skills/#{skill.id}/edit"
    fill_in 'skill[name]', with: 'updated name'
    fill_in 'skill[description]', with: 'updated description'
    click_button 'submit'

    assert_equal "/skills/#{skill.id}", current_path

    within '#skill' do
      assert page.has_content?("updated name")
    end
    within '#skill' do
      assert page.has_content?('updated description')
    end
  end
end
