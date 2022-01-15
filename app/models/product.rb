class Product < ApplicationRecord
  belongs_to :category
  has_many :stocks
  has_one_attached :photo
end
