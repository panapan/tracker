namespace :tracks do

  desc "Refresh parcels tracks and send mail to subscribers"
  task refresh: :environment do
    Parcel.where( delivered: false ).each do |parcel|
        
      UserMailer.send_status(parcel).deliver_now if
       parcel.user.notify? if
        parcel.query()

    end
  end
end
