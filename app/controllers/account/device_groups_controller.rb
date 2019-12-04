class Account::DeviceGroupsController < Account::AccountController
  def index
    @device_groups = collection
  end

  def show
    @device_group = resource
  end

  def new
    @device_group = DeviceGroup.new
  end

  def create
    @device_group = DeviceGroup.new
    @device_group.organization = current_organization
    if @device_group.save
      flash[:success] = 'Device group succcessfully created.'
      redirect_to account_device_groups_path
    else
      flash[:danger] = 'Failed to create device group.'
      render :new
    end
  end

  def edit
    @device_group = resource
  end

  def update
    @device_group = resource
    if @device_group.update(device_group_params)
      flash[:success] = 'Device group update.'
      redirect_to account_device_groups_path
    else
      flash[:danger] = "Error updating device group."
      render :edit
    end
  end

  def destroy
    @device_group = resource
    if @device_group.destroy
      flash[:success] = 'Device group successfilly deleted.'
    else
      flash[:danger] = 'Failed to delete device.'
    end
    redirect_to account_device_groups_path
  end

  private

  def device_group_params
    params.require(:device_group).permit(:name, :descrition)
  end

  def collection
    if current_user.super_admin?
      DeviceGroup.all
    else
      current_organization.device_groups
    end
  end

  def resource
    collection.find(params[:id])
  end
end
