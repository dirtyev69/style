class Admin::PaintingsController < Admin::BaseController
  def new
    @painting = Painting.new(:gallery_id => params[:gallery_id])
  end

  def create
    puts 'asdasdasd'
    @painting = Painting.new(params[:painting])
    if @painting.save
      flash[:notice] = "Successfully created painting."
      redirect_to admin_gallery_path(@painting.gallery)
    else
      render :action => 'new'
    end
  end

  def edit
    @painting = Painting.find(params[:id])
  end

  def update
    @painting = Painting.find(params[:id])
    if @painting.update_attributes(params[:painting])
      flash[:notice] = "Successfully updated painting."
      redirect_to admin_gallery_path(@painting.gallery)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @painting = Painting.find(params[:id])
    @painting.destroy
    flash[:notice] = "Successfully destroyed painting."
    redirect_to admin_gallery_path(@painting.gallery)
  end
end