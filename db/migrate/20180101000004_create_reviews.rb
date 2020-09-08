class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :product_id, null: false, default: 0 
      t.string :user_name,   null: false, default: "unsubscribed"
      t.text :content

      t.timestamps
    end
  end
end
