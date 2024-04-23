class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :order_detail
  belongs_to :item
  
  enum making_status: {
    not_available: 0,
    waiting: 1,
    in_progress: 2,
    completed: 3
  }
  
  validates :price, presence: true
  validates :amount, presence: true
  
end
