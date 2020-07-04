class Cab < ActiveRecord::Base
  self.per_page = 10
  has_attached_file :car_photo

  validates_attachment :car_photo,
                     content_type: { content_type: /\Aimage\/.*\z/ },
                     size: { less_than: 1.megabyte }
  validates :model, presence: true
  validates :mileage, presence: true
  validates :plate_number, presence: true
  validates_uniqueness_of :plate_number

  COLUMNS = %w[A B C D].freeze

  def self.fill_data
    @filename = 'cabs-list.ods'
    @path = "#{Rails.root}/public/#{@filename}"
    @cabs = Cab.pluck(:id, :model, :plate_number, :mileage)

    file = File.join(Rails.root, 'app', 'assets', 'cabs-list.ods')

    @book = Rspreadsheet.open(file)
    @sheet = @book.worksheet(1)
    @row = 2

    @cabs.each do |cab|
      cab.each_with_index do |v, i|
        @sheet[COLUMNS[i], @row] = v
      end
      @row += 1
    end

    @book.save(@path)

    return @path, @filename
  end
end
