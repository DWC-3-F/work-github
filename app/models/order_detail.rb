class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  enum making_status: {
    not_available: 0,
    waiting: 1,
    in_progress: 2,
    completed: 3
  }
end
