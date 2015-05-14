class Parcel < ActiveRecord::Base
  belongs_to :user
  has_many :tracks, dependent: :destroy
  default_scope -> { order('created_at DESC') }

  validates :user_id, presence: true
  validates :num, presence: true, length: { maximum: 14 }

  before_save { num.upcase! unless num.nil? }
end
