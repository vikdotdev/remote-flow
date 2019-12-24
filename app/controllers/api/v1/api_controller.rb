class Api::V1::ApiController < ApplicationController

  def current_organization
    Organization.where(token: request.headers['token'])
  end
end
