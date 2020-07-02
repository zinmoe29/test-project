class CarSerializer < ActiveModel::Serializer
  attributes :id, :model,  :plate_number, :mileage
end
