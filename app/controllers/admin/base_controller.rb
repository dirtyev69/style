class Admin::BaseController < ApplicationController

  layout 'admin'

  helper_method :show_breadcrumbs?

  # add_breadcrumb 'admin area', :admin_path

protected
  def show_breadcrumbs?
    true
  end
end