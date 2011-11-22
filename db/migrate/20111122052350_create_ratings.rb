class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :title
      t.integer :stars
      t.text :comments
      t.string :name

      t.timestamps
    end
  end
end
