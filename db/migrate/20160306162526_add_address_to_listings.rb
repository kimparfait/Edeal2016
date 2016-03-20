class AddAddressToListings < ActiveRecord::Migration
  def change
    add_column :listings, :address, :text
  end
end
