require 'rails_helper'

RSpec.feature "Task management function", type: :feature do
 background do
  User.create!( email: 'Foo@gmail.Com',  password: '123456', username: "meddy" )
  visit  root_path
  fill_in  'Email' ,  with: 'Foo@gmail.Com'
  fill_in  'Password' ,  with: '123456'
  click_on  'Log in'
  expect(page ).to have_text('Tasks')
  click_on 'New Task'
  fill_in  'Name' ,  with: 'grettings'
  fill_in  'Details' ,  with: 'testtesttest'
  fill_in  'State' ,  with: 'testtesttest1'
  fill_in  'Priority' ,  with: 'testtesttest2'
  click_on '登録する'
  click_on 'Back'
  click_on 'New Task'
  fill_in  'Name' ,  with: 'gre'
  fill_in  'Details' ,  with: 'sample'
  fill_in  'State' ,  with: 'testtesttest3'
  fill_in  'Priority' ,  with: 'testtesttest4'
  click_on '登録する'
  click_on 'Back'
 end
 scenario "Test task list" do
  
  expect(page).to have_content 'testtesttest'
  expect(page).to have_content 'sample'
 visit tasks_path
 
 end
 scenario "Test task creation" do
   
  visit new_task_path
  
  fill_in 'Name', with: 'task'
  fill_in 'Details', with: 'successfully created'
  fill_in  'State' ,  with: 'completed'
  fill_in  'Priority' ,  with: 'low'
  
  click_on  '登録する'
  expect(page).to have_content('task')
  expect(page).to have_content('successfully created')
  
 end
 scenario "Test task details" do
   task1=Task.first
   visit task_path(id: task1.id)
   expect(page).to have_content('testtesttest')
  
 end
 scenario "Test task updating" do
   task1=Task.first
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
  @task = Task.first
  @task_newest = Task.last
  task  = Task.order('created_at desc').all
  expect(task).to eq([@task_newest, @task])
 end


 scenario "Test whether tasks are arranged in descending order of deadline" do
  
    @task = Task.first
    @task_newest = Task.last
    @task_newest.end_date = '10.10.2020'
    @task_newest.save
    
    task  = Task.order('end_date desc').all
    save_and_open_page
  expect(task).to eq([@task_newest, @task])
  
end
scenario "test task search" do
  visit tasks_path
  fill_in  'term' ,  with: 'grettings'
  click_on 'find'
  expect(page).to have_content('grettings')
end
scenario "Test whether tasks are sorted in high order by priority" do
  Task.order('priority asc')
 end

end