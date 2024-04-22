class Address < ApplicationRecord

  belongs_to :user

  belongs_to :customers
end
