class AddStampsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :created_at, :date, default: -> {'NOW()'}
  end
end
