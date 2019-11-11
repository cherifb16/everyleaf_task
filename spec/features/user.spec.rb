require 'rails_helper'
RSpec.feature "Task management function", type: :feature do
 background do
   User.create!(username:'peter', email: 'peter@gmail.Com', user_type:'admin', password: '123456')
   visit  root_path
   fill_in  'Email' ,  with: 'peter@gmail.Com'
   fill_in  'Password' ,  with: '123456'
   click_on  'Log in'
   expect(page ).to have_text('Tasks')
 end
 scenario "Test user list" do
   expect(page).to have_content 'peter'
   visit admin_users_path
   save_and_open_page
 end
 scenario "Test user details" do
   @user = User.first
   @user.username
   @user.email
 end
 scenario "Test number of users" do
  User.create!(username: 'paul', email: 'paul@gmail.com', password: '123456')
  @user = User.all.count
  expect(@user).to eq 2
end
 
scenario "Test user creation" do
  User.create!(username: 'paul', email: 'paul@gmail.com', password: '123456')
  user=User.last
  expect(user.username).to match("paul")
end
scenario "Test user details" do
  @user= User.create!(username: 'klopp', email: 'klopp@gmail.com', password: '123456')
  visit admin_user_path(id: @user.id)
  expect(page).to have_content('klopp@gmail.com')
end
scenario 'Test user Deletion' do
  User.create!(username: 'fabi', email: 'fab@gmail.com', password: '123456')
  @user = User.last
   assert @user.destroy
end
end