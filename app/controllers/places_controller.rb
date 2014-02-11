class PlacesController < ApplicationController

  def index
    #place = place
    #unless place.nil? then session[:place_id] = place.id end
  end

  def show
    @citys_pubs=BeermappingApi.fetch_pubs(session[:city])
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:city] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

end