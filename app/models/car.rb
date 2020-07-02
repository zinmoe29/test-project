class Car < ActiveRecord::Base
  self.per_page = 10
  has_attached_file :car_photo

  validates_attachment :car_photo,
                     content_type: { content_type: /\Aimage\/.*\z/ },
                     size: { less_than: 1.megabyte }
  validates :model, presence: true
  validates_uniqueness_of :plate_number
  validates :mileage, presence: true
end
