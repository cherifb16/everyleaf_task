require 'rails_helper'

RSpec.feature "Task management function", type: :feature do
  
  background do
  FactoryBot.create(:task)
  FactoryBot.create(:second_task)
  end

  scenario "Test task list" do
  Task.create!(name: 'test_task_01', details: 'testtesttest')
  Task.create!(name: 'test_task_02', details: 'samplesample')
  visit tasks_path
  expect(page).to have_content 'testtesttest'
  expect(page).to have_content 'samplesample'
  end

  scenario "Test task creation" do
  
  visit new_task_path
  fill_in  'Name' ,  with: 'completed'
  fill_in  'Details' ,  with: 'ruby task'
  click_on '登録する'
  expect(page ).to  have_content  'ruby task'
  end
  
  scenario "Test task details" do
  end

  scenario "Test whether tasks are arranged in descending order of creation date" do
  Task.create!(name: 'test_task_01', details: 'testtesttest')
  Task.create!(name: 'test_task_02', details: 'testtesttest2')
  Task.order('created_at')
  end
end