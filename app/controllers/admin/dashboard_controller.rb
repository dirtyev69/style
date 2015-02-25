class Admin::DashboardController < Admin::BaseController

  def index
  	unless current_user
  		redirect_to admin_auth_sign_in_path
  	end

  end

  def show
  end
end
