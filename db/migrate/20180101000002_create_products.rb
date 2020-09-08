class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title,  null: false, default: ""
      t.text :info
      t.integer :value, null: false, default: 0, limit: 2
      t.string :img_path

      t.timestamps
    end
  end
end
