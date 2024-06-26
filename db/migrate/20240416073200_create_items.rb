class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, unique: true
      t.text :introduction, null: false
      t.integer :price, null: false
      t.integer :genre_id, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
