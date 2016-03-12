class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "#{html_tag}".html_safe }
  def after_sign_in_path_for(resourse)
  	subscriptions_list_url
  end
end
