class Listing < ActiveRecord::Base
  is_impressionable
    acts_as_votable
        searchkick suggest: [:name] 

  def impressionist_count
    impressions.size
  end
	
	if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/,
                :storage => :dropbox, :dropbox_credentials => Rails.root.join("config/dropbox.yml"), :path => ":style/:id_filename"

end

 validates :name, :description,  :address, :phone, presence: true 
 validates :price, numericality: { greater_than: 0}
 validates :phone, length: { maximum: 14 }

 validates_attachment_presence :image
 belongs_to :user
 has_many :orders
 belongs_to :category
  belongs_to :location
  has_many   :reviews
  has_many :impressions, :as=>:impressionable

end