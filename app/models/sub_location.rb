class SubLocation < ActiveRecord::Base
  belongs_to :location
  
  # Validations
  validates_presence_of :name
  validates_presence_of :address_line_one
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone
  validates_format_of :zip, with: /\A(\d{5}(-\d{4})?)\z/, message: "should be in the form 12345 or 12345-1234"
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be in the form 412 456 7890"

  # Scopes
  scope :alphabetical, -> { order("name") }
  
end
