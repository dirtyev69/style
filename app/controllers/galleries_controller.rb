class GalleriesController < ApplicationController

  helper_method :paintings_collection, :search

  def index
    @galleries = Gallery.all
  end

protected

  def search
    params[:type] ? params[:type] : nil
  end

  def paintings_collection(gallery)
    if params[:type].present?
      @paintings_collection ||= gallery.paintings.where(:item_type => params[:type]).ordered.page(params[:page])
    else
      @paintings_collection ||= gallery.paintings.ordered.page(params[:page])
    end
  end
end
