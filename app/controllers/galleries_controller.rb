class GalleriesController < ApplicationController

  helper_method :paintings_collection, :search, :resource_gallery

  def index
    @galleries = Gallery.all

    if request.xhr?
      puts 'asdads'
      render :json => {
        :data => render_to_string(:partial => 'galleries/shared/tiles', :locals => { :articles => paintings_collection(resource_gallery) }),
        :pagination => view_context.render_pagination(paintings_collection(resource_gallery))}
      return
    end
  end

protected

  def search
    params[:type] ? params[:type] : nil
  end

  def resource_gallery
    @gallery = Gallery.find(params[:id])
  end

  def paintings_collection(gallery)
    if params[:type].present?
      @paintings_collection ||= gallery.paintings.where(:item_type => params[:type]).ordered.page(params[:page])
    elsif params[:all].present?
      @paintings_collection ||= gallery.paintings.ordered
    else
      @paintings_collection ||= gallery.paintings.ordered.page(params[:page])
    end
  end
end
