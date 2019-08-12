class AddSuggestionToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :suggestion, :boolean
  end
end
