require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers
  def test_can_create_a_task
    data = {
      title:       "some title",
      description: "some description"
    }
    task_manager.create(data)

    task = task_manager.all.last

    assert task.id
    assert_equal "some title", task.title
    assert_equal "some description", task.description
  end

  def test_it_returns_all_tasks_in_database
    data = {
      title:       "some title",
      description: "some description"
    }
    task_manager.create(data)
    task_manager.create(data)
    task_manager.create(data)

    assert_equal Task, task_manager.all.last.class
    assert_equal 3, task_manager.all.count
    assert task_manager.all.last.id
    assert_equal "some title", task_manager.all.last.title
    assert_equal "some description", task_manager.all.last.description
  end

  def test_it_can_find_a_specific_task_by_id
    data = {
      title:       "some title",
      description: "some description"
    }
    task_manager.create(data)
    task_manager.create(data)
    task_manager.create(data)

    assert_equal Task, task_manager.find(1).class
    assert_equal "some title", task_manager.find(1).title
    assert_equal "some description", task_manager.find(1).description
  end

  def test_it_can_update_an_existing_task
    data = {
      title:       "some title",
      description: "some description"
    }
    new_task = {
      title:       "new title",
      description: "new description"
    }
    task_manager.create(data)
    task_manager.create(data)
    task_manager.create(data)
    task_manager.update(1, new_task)

    assert_equal "new title", task_manager.find(1).title
    assert_equal "new description", task_manager.find(1).description
  end

  def test_it_can_delete_a_task_from_the_database
    data = {
      title:       "some title",
      description: "some description"
    }
    task_manager.create(data)
    task_manager.create(data)
    task_manager.create(data)

    assert_equal 3, task_manager.all.count

    task_manager.delete(1)

    assert_equal 2, task_manager.all.count
  end
end
