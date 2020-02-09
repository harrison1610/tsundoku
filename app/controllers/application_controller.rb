class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname])
  end


  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    books_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    books_path
  end
end
