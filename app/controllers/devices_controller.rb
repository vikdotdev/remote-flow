class DevicesController < ApplicationController
  layout 'device'

  def show
    @device = resource
  end

  private

  def resource
    Device.find_by!(token: params[:token])
  end
end

