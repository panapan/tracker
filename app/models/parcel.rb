class Parcel < ActiveRecord::Base
  belongs_to :user
  has_many :tracks, dependent: :destroy
  default_scope -> { order('created_at DESC') }

  validates :user_id, presence: true
  validates :num, presence: true, length: { minimum: 9, maximum: 14 },
   uniqueness: {scope: :user_id, case_sensitive: false},
   format: { with: /[a-z\d]+/i, message: 'Только английские буквы и цифры'}
    
    before_save { num.upcase! unless num.nil? }

  def query
    require 'open-uri'
    xml = open("http://postabot.ru/tr/tracker2.php?track-number=#{self.num}&carrier=ems").read
    hash = Hash.from_xml(xml)
    track = hash["response"]["track_number"]
    return if track['count'] == '0'

    item = track['items']['item']
    self.update_attributes( carrier: track['carrier'],
                            from_loc: item['routeStartLoc']['value'],
                            to_loc: item['routeEndLoc']['value'],
                            from_time: item["routeStartTime"]['value'].to_datetime,
                            to_time: item["routeEndTime"]['value'].to_datetime,
                            delivered: item["delivered"]['value'] == 'yes'
                            )

    items = item['tracking']['track']
    # self.tracks.destroy_all
    # items.each {|item| self.tracks.create(date: item["date"],
    #                                       time: item["time"],
    #                                       geo: item["geo"],
    #                                       event: item["event"],
    #                                       'track_id' => item["id"])}
    items.each do |item| 
      params = {track_id: item["id"],
                date_time: (item["date"]+' '+item["time"]).to_datetime,
                geo: item["geo"],
                event: item["event"]}
      find_item = self.tracks.find_by(tracks: params)
      self.tracks.create(params) if find_item.nil?
    end
  end
private

end
