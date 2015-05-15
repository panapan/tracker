class Track < ActiveRecord::Base
  belongs_to :parcel
  default_scope -> { order('track_id') }

  validates :parcel_id, presence: true
end
