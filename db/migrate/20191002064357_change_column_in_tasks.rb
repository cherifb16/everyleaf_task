class ChangeColumnInTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :created_at, :datetime, default: -> {'NOW()'}
  end
end
