class StylesController < ApplicationController

  def show
    @style = Style.find(params[:id])
    @beers = Beer.all.where(:style=>@style)
  end

  def index
    @styles = Style.all
  end

  def edit
  end
end
