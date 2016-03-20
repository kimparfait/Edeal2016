class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :address
      t.string :city
      t.string :number
      t.text :message

      t.timestamps
    end
  end
end
