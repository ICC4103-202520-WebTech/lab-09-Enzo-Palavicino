class Recipe < ApplicationRecord
  belongs_to :user
  has_rich_text :instructions

  DIFFICULTY_LEVELS = ["Easy", "Medium", "Hard"].freeze

  validates :title, presence: true
  validates :cook_time, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :difficulty, inclusion: { in: DIFFICULTY_LEVELS, allow_blank: true }
  validates :user, presence: true
end
