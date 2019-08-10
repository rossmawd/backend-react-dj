class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :url
      t.string :suggestion
      t.references :playlist, foreign_key: true
      t.integer :position
      t.string :name

      t.timestamps
    end
  end
end
