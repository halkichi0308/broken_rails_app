class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.string :user_name
      t.text :details
      t.integer :total_value,   null: false, default: 0

      t.timestamps
    end
  end
end
