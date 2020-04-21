class CreateNotesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :entry
      t.integer :user_id
    end
  end
end
