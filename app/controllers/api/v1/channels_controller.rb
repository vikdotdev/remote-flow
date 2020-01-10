class Api::V1::ChannelsController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def show
    render json: resource
  end

  def create
    @channel = collection.new(channel_params)
    if @channel.save
      render json: @channel
    else
      render json: { errors: @channel.errors }, status: :unprocessable_entity
    end
  end

  def update
    if resource.update(channel_params)
      render json: resource
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    head 200
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
