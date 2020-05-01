class CreateLogsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :log_date
      t.integer :user_id
    end
  end
end
