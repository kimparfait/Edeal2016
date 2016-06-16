class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
        validates :name, presence: true
        validates :phone, presence: true
         validates :email, uniqueness: true
         validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

        has_many :listings, dependent: :destroy
        has_many :sales, class_name:"Order", foreign_key:"seller_id"
        has_many :purchases, class_name:"Order", foreign_key:"buyer_id"
        has_many :reviews

       
end