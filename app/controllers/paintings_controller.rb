class PaintingsController < ApplicationController

  helper_method :resource_painting

  def show
    resource_painting
  end

  def new
    @painting = Painting.new(:gallery_id => params[:gallery_id])
  end

  def create
    Rails.logger
    @painting = Painting.new(params[:painting])
    if @painting.save
      flash[:notice] = "Successfully created painting."
      # redirect_to @painting.gallery
    else
      render :action => 'new'
    end
  end

  def edit
    resource_painting
  end

  def update
    @painting = Painting.find(params[:id])
    if @painting.update_attributes(params[:painting])
      flash[:notice] = "Successfully updated painting."
      # redirect_to @painting.gallery
    else
      render :action => 'edit'
    end
  end

  def destroy
    @painting = Painting.find(params[:id])
    @painting.destroy
    flash[:notice] = "Successfully destroyed painting."
    redirect_to @painting.gallery
  end

protected
  def resource_painting
    @painting = Painting.find(params[:id])
  end

end
