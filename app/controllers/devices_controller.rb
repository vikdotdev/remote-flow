class DevicesController < ApplicationController
  layout 'device'

  def show
    @device = Device.find_by(token: params[:token])
  end
end
