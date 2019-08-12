class RemoveSuggestionFromListings < ActiveRecord::Migration[5.2]
  def change
    remove_column :listings, :suggestion, :string
  end
end
