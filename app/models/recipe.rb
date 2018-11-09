class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  validates :title, :description, presence: true, uniqueness: true

  has_one_attached :image
  delegate :filename, to: :image, allow_nil: true

  has_many :directions
  has_many :ingredients
  accepts_nested_attributes_for :ingredients,
																reject_if: proc {|attributes| attributes['name'].blank?},
																allow_destroy: true
	accepts_nested_attributes_for :directions,
																reject_if: proc {|attributes| attributes['step'].blank?},
																allow_destroy: true

  has_many :reviews
  scope :order_and_categories, -> { order("title").includes(:categories)}
end
