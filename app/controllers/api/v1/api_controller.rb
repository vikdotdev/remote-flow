class Api::V1::ApiController < ApplicationController

  def token
    request.headers['token']
  end

  def current_organization
    @current_organization ||= Organization.find_by(token: token)
  end
end
