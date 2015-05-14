class PagesController < ApplicationController
  def home
    @parcel=Parcel.new
    @parcels = self.current_user.parcels.paginate(page: params[:page],
      :per_page => 10) unless self.current_user.nil?
  end

  def help
  end

  def about
  end
end
