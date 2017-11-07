class Review < ActiveRecord::Base
  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  belongs_to :user
  belongs_to :product

  before_save do
    self.rating = rating.to_i
  end
end
