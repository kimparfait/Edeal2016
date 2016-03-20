class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
        validates :name, presence: true
        validates :phone, presence: true
         validates :email, uniqueness: true

        has_many :listings, dependent: :destroy
        has_many :sales, class_name:"Order", foreign_key:"seller_id"
        has_many :purchases, class_name:"Order", foreign_key:"buyer_id"
        has_many :reviews

        has_attached_file :profil, styles: { medium: "200x>", thumb: "100x100>" }, default_url: "default.jpg"
  validates_attachment_content_type :profil, content_type: /\Aimage\/.*\Z/
end