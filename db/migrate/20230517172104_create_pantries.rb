class CreatePantries < ActiveRecord::Migration[6.0]
  def change
    create_table :pantries do |t|
      t.string :item
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
