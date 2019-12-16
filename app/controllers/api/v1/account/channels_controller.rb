class Api::V1::Account::ChannelsController < AccountController
  def index
    @channels = Channel.all

    render json: @channels
  end
end