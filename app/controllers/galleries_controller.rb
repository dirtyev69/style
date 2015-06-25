class GalleriesController < ApplicationController

  helper_method :paintings_collection

  def index
    @galleries = Gallery.all
  end

protected

  def paintings_collection(gallery)
    @paintings_collection ||= gallery.paintings.page(params[:page])
  end
end
