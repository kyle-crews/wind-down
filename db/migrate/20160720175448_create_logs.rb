class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string  :description
      t.float   :amount
      t.string  :date
      t.integer :day_id
      t.integer :user_id
    end
  end
end
