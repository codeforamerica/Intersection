class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user


  def set_user
    $current_user = current_user if current_user
  end

  def is_admin?
    authenticate_user! and return unless current_user
    unless current_user.admin?
      flash[:error] = "You need to be an admin to do that."
      redirect_to root_path and return
    end
  end


end
