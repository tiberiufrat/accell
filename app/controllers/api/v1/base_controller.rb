# https://github.com/oddcamp/labs.kollegorna.se/blob/master/source/posts/2015-04-09-build-an-api-now.html.md#adding-authentication
class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  def destroy_session
    request.session_options[:skip] = true
  end

end
