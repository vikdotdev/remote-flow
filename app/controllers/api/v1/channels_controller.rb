class Api::V1::ChannelsController < ApiController
  def index
    @channels = Channel.all

    render json: @channels
  end
end