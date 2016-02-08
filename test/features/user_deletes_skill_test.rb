require_relative '../test_helper'

class UserCanDeleteAnExistingTask < FeatureTest
  def test_existing_skill_is_deleted_successfully
    skill_inventory.create({
      name: 'Original Title',
      description: 'Original Description'
    })

    visit '/skills'

    assert page.has_content? 'Original Title'

    click_button 'Delete'

    within '#skills' do
      refute page.has_content? 'Original Title'
    end
  end
end
