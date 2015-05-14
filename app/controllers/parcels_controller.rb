class ParcelsController < ApplicationController
  before_action :own_parcel,   only: [:destroy, :update, :show]

  def create
    self.current_user ||= User.new()
    @parcel = self.current_user.parcels.build(parcel_params)
    if @parcel.save
      flash[:warning] = 
        "Зарегистрируйтесь, чтобы не потерять добавленные посылки" if
        self.anonymous?

      # flash[:success] = "Отправление успешно добавлено"
      # redirect_to root_url
      render js: "window.location = '#{root_path}'"
    else
      respond_to do |format|
        format.html do
          # @parcel=Parcel.new
          @parcels = self.current_user.parcels.paginate(page: params[:page],
           :per_page => 10) unless self.current_user.nil?
          render 'pages/home' 
        end # parcels get broken - fixed!
        format.js
      end
    end
  end

  def show #used to refresh parcel status
    @parcel.note += '_ajacs'
    # @parcel.save
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end


  end

  def update #used to update note field
    @parcel.update_attributes(params.require(:parcel).permit(:note))
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end

  end

  def destroy
    @parcel.destroy
    redirect_to root_url
  end
  
  private
    def parcel_params
      params.require(:parcel).permit(:num, :note)
    end

    def own_parcel
      @parcel = current_user.parcels.find_by(id: params[:id])
      if @parcel.nil?
        flash[:danger] = 'Посылка не найдена'
        redirect_to root_url 
      render js: "window.location = '#{root_path}'"
      end
    end
end

