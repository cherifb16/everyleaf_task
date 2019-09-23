class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :details
      t.string :state
      t.string :priority
      t.datetime :end_date
    end
  end
end
