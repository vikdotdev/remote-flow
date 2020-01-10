class Api::V1::ChannelsController < Api::V1::ApiController
  def show
    @channel = resource
    render json: @channel
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
    @channel = resource
    if @channel.update(channel_params)
      render json: @channel
    else
      render json: { errors: @channel.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @channel = resource
    @channel.destroy
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
