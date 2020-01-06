class Api::V1::ChannelsController < Api::V1::ApiController

  def index
    paginate json: current_organization.channels
  end
end
