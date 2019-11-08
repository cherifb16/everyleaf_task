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
  click_on '登録する'
  click_on 'Back'
  click_on 'New Task'
  fill_in  'Name' ,  with: 'gre'
  fill_in  'Details' ,  with: 'sample'
  click_on '登録する'
  click_on 'Back'
 end
 scenario "Test task list" do
  
  expect(page).to have_content 'testtesttest'
  expect(page).to have_content 'sample'
 visit tasks_path
 
 end
 
 scenario "test task search by atached labels " do
  visit labels_path
  click_on 'New Label'
  fill_in 'Title', with: 'label title1'
  fill_in 'Content', with: 'label content1'
  click_on '登録する'
  visit labels_path
  click_on 'New Label'
  fill_in 'Title', with: 'label title2'
  fill_in 'Content', with: 'label content2'
  click_on '登録する'
  @task = Task.first
  @label1 = Label.first
  @label2 = Label.last
  @task.labels = [@label1,@label2]
  @task.save
  
  visit tasks_path
  save_and_open_page
  fill_in  'term3' ,  with: 'label title1'
  click_on '  Search'
  expect(page).to have_content('grettings')
end
end

