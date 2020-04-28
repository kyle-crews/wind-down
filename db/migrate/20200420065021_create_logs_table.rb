class CreateLogsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :entry
      t.integer :user_id
    end
  end
end
