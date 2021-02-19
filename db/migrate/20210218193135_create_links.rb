class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :shortened_url, null: false
      t.integer :counter, null: false, default: 0

      t.timestamps
    end

    add_index :links, :shortened_url, unique: true
  end
end
