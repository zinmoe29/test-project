class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :plate_number
      t.string :model
      t.string :mileage
      t.attachment :car_photo

      t.timestamps null: false
    end
  end
end
