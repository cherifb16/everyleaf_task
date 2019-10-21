require 'rails_helper'
RSpec.feature "Task management function", type: :feature do
 background do
   User.create!(username:'peter', email: 'peter@gmail.Com',  password: '123456')
   User.create!(username:'john', email: 'john@gmail.Com',  password: '123456')
   visit  root_path
   fill_in  'Email' ,  with: 'peter@gmail.Com'
   fill_in  'Password' ,  with: '123456'
   click_on  'Log in'
   expect(page ).to have_text('Tasks')
 end
 scenario "Test user list" do
   expect(page).to have_content 'peter'
   visit users_path
   save_and_open_page
 end
 scenario "Test user details" do
   @user = User.first
   @user.username
   @user.email
 end
end