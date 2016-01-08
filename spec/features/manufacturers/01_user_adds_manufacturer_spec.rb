require 'rails_helper'

feature 'add a car manufacturer', %{
  As a car salesperson
  I want to record a car manufacturer
  So that I can keep track of the types of cars found in the lot
} do

  # Acceptance Criteria:
  # [x] I must specify a manufacturer name and country.
  # [x] If I do not specify the required information, I am presented with errors.
  # [x] If I specify the required information, the manufacturer is recorded and I am redirected to the index of manufacturers

  scenario 'user specifies valid and required information' do
    visit root_path
    click_link 'Manufacturer Index'
    click_link 'Add New Manufacturer'

    fill_in 'Name', with: 'Honda'
    fill_in 'Country', with: 'Japan'
    click_button 'Add Manufacturer'

    expect(page).to have_content('Manufacturer Successfully Added!')
    expect(page).to have_content('Name: Honda')
    expect(page).to have_content('Country: Japan')
  end

  scenario 'user leaves name field blank' do
    visit new_manufacturer_path
    fill_in 'Country', with: 'Japan'
    click_button 'Add Manufacturer'

    expect(page).to have_content("Name can't be blank")
    expect(page).to_not have_content('Manufacturer Successfully Added!')
    expect(find_field('manufacturer[country]').value).to eq('Japan')
  end

  scenario 'user leaves country field blank' do
    visit new_manufacturer_path
    fill_in 'Name', with: 'Honda'
    click_button 'Add Manufacturer'

    expect(page).to have_content("Country can't be blank")
    expect(page).to_not have_content('Manufacturer Successfully Added!')
    expect(find_field('manufacturer[name]').value).to eq('Honda')
  end
end
