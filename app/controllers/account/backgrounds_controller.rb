class Account::BackgroundsController < Account::AccountController
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render json: collection }
    end
  end

  def create
    collection.create(background_params)
  end

  def destroy
    resource.destroy
    head :ok
  end

  private

  def background_params
    params.permit(:image)
  end

  def collection
    current_organization.backgrounds
  end

  def resource
    collection.find(params[:id])
  end
end
