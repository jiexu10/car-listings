require 'rails_helper'

feature 'add a car manufacturer', %{
  As a car salesperson
  I want to record a newly acquired car
  So that I can list it in my lot
} do

  # Acceptance Criteria:
  # [x] I must specify the manufacturer, color, year, and mileage of the car (an association between the car and an existing manufacturer should be created).
  # [x] Only years from 1920 and above can be specified.
  # [x] I can optionally specify a description of the car.
  # [x] If I enter all of the required information in the required formats, the car is recorded and I am presented with a notification of success.
  # [x] If I do not specify all of the required information in the required formats, the car is not recorded and I am presented with errors.
  # [x] Upon successfully creating a car, I am redirected back to the index of cars.

  let!(:manufacturer) { Manufacturer.create({name: 'Honda', country: 'Japan'}) }

  scenario 'user specifies all valid and required information' do
    visit root_path
    click_link 'Add New Car'

    select "#{manufacturer.name}", from: 'car[manufacturer_id]'
    fill_in 'Color', with: 'Black'
    fill_in 'Year', with: '2010'
    fill_in 'Mileage', with: '55000'
    fill_in 'Description', with: 'some description'
    click_button 'Add Car'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Car Successfully Added!')
    expect(page).to have_content('Manufacturer: Honda')
    expect(page).to have_content('Color: Black')
    expect(page).to have_content('Year: 2010')
    expect(page).to have_content('Mileage: 55000')
    expect(page).to have_content('Description: some description')
  end

  scenario 'user specifies a year before 1920' do
    visit new_car_path

    select "#{manufacturer.name}", from: 'car[manufacturer_id]'
    fill_in 'Color', with: 'Black'
    fill_in 'Year', with: '1910'
    fill_in 'Mileage', with: '55000'
    click_button 'Add Car'

    expect(page).to have_content('Year must be after 1920.')
    expect(page).to_not have_content('Car Successfully Added!')
    expect(find_field('car[manufacturer_id]').value).to eq("#{manufacturer.id}")
    expect(find_field('car[color]').value).to eq('Black')
    expect(find_field('car[year]').value).to eq('1910')
    expect(find_field('car[mileage]').value).to eq('55000')
  end

  scenario 'user specifies an invalid mileage' do
    visit new_car_path

    select "#{manufacturer.name}", from: 'car[manufacturer_id]'
    fill_in 'Color', with: 'Black'
    fill_in 'Year', with: '2010'
    fill_in 'Mileage', with: 'asdf'
    click_button 'Add Car'

    expect(page).to have_content('Mileage must be a number.')
    expect(page).to_not have_content('Car Successfully Added!')
    expect(find_field('car[manufacturer_id]').value).to eq("#{manufacturer.id}")
    expect(find_field('car[color]').value).to eq('Black')
    expect(find_field('car[year]').value).to eq('2010')
    expect(find_field('car[mileage]').value).to eq('asdf')
  end

  scenario 'user does not specify description and entry is valid' do
    visit new_car_path

    select "#{manufacturer.name}", from: 'car[manufacturer_id]'
    fill_in 'Color', with: 'Black'
    fill_in 'Year', with: '2010'
    fill_in 'Mileage', with: '55000'
    click_button 'Add Car'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Car Successfully Added!')
    expect(page).to have_content('Manufacturer: Honda')
    expect(page).to have_content('Color: Black')
    expect(page).to have_content('Year: 2010')
    expect(page).to have_content('Mileage: 55000')
    expect(page).to_not have_content('Description:')
  end

  scenario 'user leaves fields blank' do
    visit new_car_path

    click_button 'Add Car'

    expect(page).to have_content("Manufacturer can't be blank.")
    expect(page).to have_content("Color can't be blank.")
    expect(page).to have_content("Year can't be blank.")
    expect(page).to have_content("Mileage can't be blank.")
    expect(page).to_not have_content('Car Successfully Added!')
  end
end
