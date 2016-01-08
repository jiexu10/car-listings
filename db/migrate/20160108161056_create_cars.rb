class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.belongs_to :manufacturer, null: false
      t.string :color, null: false
      t.string :year, null: false
      t.string :mileage, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
