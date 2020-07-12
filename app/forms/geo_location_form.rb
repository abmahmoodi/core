class GeoLocationForm < Reform::Form
  property :title
  property :parent_id
  property :root
  property :price_factor

  # validates_uniqueness_of :title
  validates :title, presence: true
end
