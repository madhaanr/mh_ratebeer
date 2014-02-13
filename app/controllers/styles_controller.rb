class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit, :update, :destroy]

  def show
    @beers = Beer.all.where(:style=>@style)
  end

  def index
    @styles = Style.all
  end

  def edit
  end

  def new
    @style = Style.new
  end

=begin
  def update
    @style = Style.find(params[:id])
    @style.update_attributes!(params[:description])
    byebug
    redirect_to style_path(@style)
  end
=end
  def create

    @style = Style.new(style_params)

    respond_to do |format|
      if @style.save
        format.html { redirect_to styles_path, notice: 'Style was successfully created.' }
        format.json { render action: 'show', status: :created, location: @style }
      else
        format.html { render action: 'new' }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to @style, notice: 'Style was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @style.destroy
    respond_to do |format|
      format.html { redirect_to styles_url }
      format.json { head :no_content }
    end
  end

  private

  def style_params
    params.require(:style).permit(:name, :description)
  end

  def set_style
    @style = Style.find(params[:id])
  end
end
