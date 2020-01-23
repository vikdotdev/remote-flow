class Account::BackgroundsController < Account::AccountController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render json: BackgroundSerializer.new(collection.reverse_order) }
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
