class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_datails
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  enum status: {
    awaiting_payment: 0,
    payment_confirmed: 1,
    in_production: 2,
    preparing_for_shipping: 3,
    shipped: 4
  }
end
