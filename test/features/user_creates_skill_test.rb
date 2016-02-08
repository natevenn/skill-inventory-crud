require_relative '../test_helper'

class UserCreatesSkillTest < FeatureTest
  # include Capybara::DSL

  def test_with_valid_attributes
    visit '/skills/new'

    fill_in 'skill[name]', with: 'coding'
    fill_in 'skill[description]', with: 'html'
    click_button 'submit'

    assert_equal '/skills', current_path

    within '#skills' do
      assert page.has_content?('coding')
    end
  end
end
