require 'rails_helper'

RSpec.describe Task, type: :model do
 it "Validation does not pass if the name is empty" do
   task = Task.new(name: '', details: 'Failure test')
   expect(task).not_to be_valid
 end
 it "Validation does not pass if details is empty" do
   task = Task.new(name: 'welcome', details: '')
   expect(task).not_to be_valid
 end
 it "validation passes If content is described in title and content" do
   task = Task.new(name: '', details: '')
   expect(task).not_to be_valid
 end
 scenario "test task search " do
 
  Task.all.where('name LIKE ? or state LIKE ?')
end
end
