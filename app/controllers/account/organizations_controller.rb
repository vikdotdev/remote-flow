class Account::OrganizationsController < Account::AccountController

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
    if @organization.update(organization_params)
      redirect_to account_organization_path(@organization)
      flash[:success] = "Organization successfully updated"
    else
      redirect_to organizations: :edit
      flash[:error] = "Failed to update organization"
    end
  end

  def destroy
    @organization = resource
    if @organization.destroy
      flash[:success] = "Organization successfully deleted"
      if current_user.super_admin?
        redirect_to account_organizations_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Failed to delete organization"
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :logo, :logo_cache, :remove_logo)
  end

  def collection
    if current_user.super_admin?
      Organization.all
    else
      Organization.where(id: current_organization.id)
    end
  end

  def resource
    collection.find(params[:id])
  end
end
