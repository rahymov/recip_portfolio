class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  validates :title, :description, presence: true, uniqueness: true
  has_one_attached :image

  def order_by_desc
    order.("created_at DESC")
  end
end
