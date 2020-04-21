class CreateTasksTable < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :entry
      t.integer :user_id
    end
  end
end
