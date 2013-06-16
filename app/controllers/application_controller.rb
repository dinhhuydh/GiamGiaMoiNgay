class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_session

  def after_sign_in_path_for(resource)
    session[:redirect_to] || root_path
  end

  private

  def set_session
    session[:redirect_to] = params[:redirect_to] if params[:redirect_to]
  end
end
