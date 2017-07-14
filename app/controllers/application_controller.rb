class ApplicationController < ActionController::Base

  include ApplicationHelper

  helper_method :current_session

  protect_from_forgery with: :exception


end
