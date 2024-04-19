class Item < ApplicationRecord
  
  has_many :cart_items
  belongs_to :genres
  
  has_one_attached :image
end
