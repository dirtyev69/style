class Admin::ImagesController < Admin::BaseController
  def create

    resource_image.save
    respond_to do |format|
      format.html do
        render :partial => 'galleries/item', :locals => { :painting => resource_image }
      end
    end
  end

  def update
    if resource_image.update_attributes(params[:image])
      respond_to do |format|
        format.json do
          render(:json => { :image => resource_image, :flash => I18n.t('flash.saved', resource_name: Content::Image.model_name.human) }.to_json, :status => 200)
        end
      end
    end
  end

  def destroy
    resource_image.destroy
    respond_to do |format|
      format.json do
        render :json => { :status => :ok }
      end
    end
  end

  def sort
    resource_image.move_to!(params[:position])
    render :nothing => true
  end

protected

  def resource_image
    @resource_image ||= Painting.new(params[:image])
  end
end