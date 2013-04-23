class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.datetime :date
      t.integer :user_id
      t.integer :view_count

      t.timestamps
    end
  end
end
