class Track < ActiveRecord::Base
  belongs_to :parcel
  default_scope -> { order('track_id') }
end
