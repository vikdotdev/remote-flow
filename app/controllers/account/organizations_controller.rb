class Account::OrganizationsController < Account::AccountController

  before_action :require_super_admin_only!

  def index
    @organizations = collection.by_name.page(params[:page]).per(10)
  end

  def show
    @organization = resource
  end

  def edit
    @organization = resource
  end

  def update
    @organization = resource
    if resouerce.update(organization_params)
      redirect_to account_organization_path(@organization)
      flash[:success] = 'Organization successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @organization = resource
    if resource.destroy
      flash[:success] = 'Organization successfully deleted'
    else
      flash[:error] = 'Failed to delete organization'
    end

    redirect_to account_organizations_path
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :logo, :logo_cache, :remove_logo)
  end

  def collection
    Organization.all
  end

  def resource
    collection.find(params[:id])
  end
end
