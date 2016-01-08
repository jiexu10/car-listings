class Car < ActiveRecord::Base
  belongs_to :manufacturer

  validates :manufacturer, presence: true
  validates :color, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than: 1920, message: "must be after 1920" }
  validates :mileage, presence: true
end
