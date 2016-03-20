class AddPhoneToListings < ActiveRecord::Migration
  def change
    add_column :listings, :phone, :string
  end
end
