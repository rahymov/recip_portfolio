class Recipe < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true, uniqueness: true
end
