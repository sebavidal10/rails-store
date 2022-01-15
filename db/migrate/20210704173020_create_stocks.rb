class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.integer :price
      t.boolean :enabled
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
