class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string  :good
      t.string  :accomplishment
      t.string  :date
      t.integer :day_id
      t.integer :user_id
    end
  end
end
