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
    @paintings_collection ||= gallery.paintings.where(:item_type => params[:type]).ordered.page(params[:page])
  end
end
