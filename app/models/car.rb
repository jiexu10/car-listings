class Car < ActiveRecord::Base
  belongs_to :manufacturer

  validates :manufacturer, presence: true
  validates :color, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than: 1920, message: "must be after 1920." }
  validates :mileage, presence: true, numericality: { only_integer: true, message: 'must be a number.' }

  def condition
    year_int = year.to_i
    mileage_int = mileage.to_i

    if year_int >= 2015 && mileage_int <= 10000
      'Excellent'
    elsif year_int >= 2009 && mileage_int <= 100000
      'Good'
    elsif year_int >= 2003 && mileage_int <= 250000
      'Fair'
    else
      'Poor'
    end
  end
end
