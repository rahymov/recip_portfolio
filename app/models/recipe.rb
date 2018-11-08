class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  validates :title, :description, presence: true, uniqueness: true
  has_one_attached :image
  scope :order_and_categories, -> { order("title").includes(:categories)}
end
