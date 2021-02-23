class Product < ApplicationRecord
	before_destroy :not_referenced_by_any_line_item
  belongs_to :category

  has_attached_file :image, styles: { medium: "250x150>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :line_items

  private

   def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line items present')
      throw :abort
    end
   end
end
