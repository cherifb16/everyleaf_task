# In this require, the feature required for Feature Spec such as Capybara are available.
require 'rails_helper'
# On the right side of this RSpec.feature, write the test item name like "task management feature" (grouped by do ~ end)
RSpec.feature "Task management function", type: :feature do
 background do
   FactoryBot.create(:task, name: 'Added name 1')
   FactoryBot.create(:task, name: 'Added name 2')
   FactoryBot.create(:second_task, name: 'Added name 3', details: 'Added content')
 end
 scenario "Test task list" do
 visit tasks_path
 
 end
 scenario "Test task creation" do
    # visit to new_task_path (transition to task registration page)
  visit new_task_path
  # In the input field labeled "Task Name" and in the input field labeled "Task Details"
  # Fill in the task title and content respectively
  fill_in  'Name' ,  with: 'completed'
  fill_in  'Detail' ,  with: 'ruby task'
  fill_in  'State' ,  with: 'completed'
  fill_in  'Priority' ,  with: 'low'
  # Click_on a button with a value (notation letter) of “Register”
  click_on  '登録する'
  # Check if the information that is supposed to be registered by click is displayed on the task detail page
  # (Assumption that transition to the task details screen will be made if the task is registered)
 end
 scenario "Test task details" do
   task1=Task.create!(name: 'test_task_03', details: 'samplesample',state: 'completed',priority:'low',created_at:'2019-09-09',end_date:'2019-09-12')
   visit task_path(id: task1.id)
   expect(page).to have_content('test_task_03')
   expect(page).to have_content('samplesample')
 end
 scenario "Test task updating" do
   task1=Task.create!(name: 'test_task_03', details: 'samplesample',state: 'completed',priority:'low',created_at: '2019-09-09',end_date: '2019-09-12')
   visit edit_task_path(id: task1.id)
   fill_in 'Name', with: 'suredeal'
   fill_in 'Detail', with: 'of course'
   fill_in  'State' ,  with: 'completed'
  fill_in  'Priority' ,  with: 'low'
   click_on '更新する'
   visit tasks_path
   expect(page).to have_content('suredeal')
   expect(page).to have_content('of course')
 end
 scenario "Test whether tasks are arranged in descending order of creation date" do
   Task.order('created_at desc')
 end
 scenario "Test whether tasks are sorted in high order by priority" do
  Task.order('priority asc')
end
end