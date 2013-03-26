class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  before_filter :require_email

  def require_email
    if current_user && current_user.email.blank?
      redirect_to edit_user_path(session[:user_id])
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
