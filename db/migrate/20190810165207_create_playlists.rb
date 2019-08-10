class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :description
      t.boolean :party
      t.string :genre
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
