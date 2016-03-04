require_relative '../test_helper'

class UserCreatesTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_existing_task_is_deleted_successfully
    task_manager.create({
      title: 'Original Title',
      description: 'Original Description'
    }
    visit '/tasks'
    save_and_open_page
    assert page.has_content? 'Original Title'

    click_button 'delete'

    within '#tasks' do
      refute page.has_content? 'Original Title'
    end
  end
end
