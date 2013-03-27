class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :xml, :json

  # declarative authorization setup
  before_filter :set_current_user

  protected

  def set_current_user
    Authorization.current_user = current_user
  end

  # will be called if user isn't authorized to access the requested controller/action
  def permission_denied
    if current_user
      response.status = 403
      render "global/403"
    else
      flash[:error] = I18n.t("devise.failure.unauthenticated")
      session[:user_return_to] = request.fullpath
      redirect_to new_user_session_path()
    end
  end

end
