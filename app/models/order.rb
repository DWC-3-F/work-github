class Order < ApplicationRecord
  belongs_to :customers
  has_many :order_datails
  
  enum payment_method: { credit_card: 0, transfer: 1 }
end
