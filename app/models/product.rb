class Product < ApplicationRecord
  validates :title, :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validate :title_is_shorter_than_description

  belongs_to :category

  before_save :strip_html_from_description
  before_save :set_title_to_lower_case

  def strip_html_from_description
    self.description = ActionView::Base.full_sanitizer.santitize(self.description)
  end

  def title_is_shorter_than_description
    return if title.blank? or description.blank?
    if description.length < title.length
      errors.add(:description, 'can\'t be shorter than title')
    end
  end

  def set_title_to_lower_case
    self.title = self.title.downcase
  end
end