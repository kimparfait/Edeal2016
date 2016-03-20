class AddAttachmentProfilToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :profil
    end
  end

  def self.down
    remove_attachment :users, :profil
  end
end
