class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :handle_error

  private

  def handle_error(e)
    render json: { error: e.to_s }, status: :bad_request
  end

  def current_organization
    @current_organization ||= Organization.find_by!(token: request.headers['Token'])
  end
end
