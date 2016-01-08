require 'rails_helper'

RSpec.describe Car, type: :model do
  it 'correctly evaluates the condition of a car' do
    honda = Manufacturer.create({name: 'Honda', country: 'Japan'})
    excellent_car = Car.create({ manufacturer: honda, color: 'Black', year: '2015', mileage: '100'})
    good_car = Car.create({ manufacturer: honda, color: 'Black', year: '2010', mileage: '30000'})
    fair_car = Car.create({ manufacturer: honda, color: 'Black', year: '2005', mileage: '200000'})
    poor_car = Car.create({ manufacturer: honda, color: 'Black', year: '2000', mileage: '500000'})

    expect(excellent_car.condition).to eq('Excellent')
    expect(good_car.condition).to eq('Good')
    expect(fair_car.condition).to eq('Fair')
    expect(poor_car.condition).to eq('Poor')
  end
end
