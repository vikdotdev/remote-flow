class Api::V1::ChannelsController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def show
    render json: resource
  end

  def create
    @channel = Channel.new(channel_params)
    @channel.organization = current_organization
    if @channel.save
      render json: @channel
    end
  end

  def update
    if resource.update(channel_params)
      render json: resource
    end
  end

  def destroy
    resource.destroy
    render json: current_organization
  end

  private

  def collection
    current_organization.channels
  end

  def resource
    collection.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:name)
  end
end
