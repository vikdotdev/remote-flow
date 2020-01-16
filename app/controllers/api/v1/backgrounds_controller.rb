class Api::V1::BackgroundsController < Api::V1::ApiController
  def index
    render json: collection
  end

  def create
    render json: Background.create(background_params)
  end

  def destroy
    resource.destroy
    head :ok
  end

  private

  def background_params
    params.require(:background).permit(:image)
  end

  def collection
    current_organization.backgrounds
  end

  def resource
    collection.find(params[:id])
  end
end
