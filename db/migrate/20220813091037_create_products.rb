class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|

      t.references :user,               null: false, foreign_key: true
      t.string     :product_name,       null: false
      t.text       :description,        null: false
      t.integer    :price,              null: false
      t.integer    :category_id,        null: false
      t.integer    :condition_id,       null: false
      t.integer    :delivery_charge_id, null: false
      t.integer    :prefecture_id,      null: false
      t.integer    :delivery_days_id,   null: false

      t.timestamps
    end
  end
end
