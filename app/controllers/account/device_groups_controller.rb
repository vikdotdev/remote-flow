class Account::DeviceGroupsController < Account::AccountController
  def index
    @device_groups = collection.by_name.page(params[:page]).per(10)
  end

  def show
    @device_group = resource
  end

  def new
    @device_group = DeviceGroup.new
  end

  def create
    @device_group = DeviceGroup.new(device_group_params)
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
      flash[:success] = 'Device group updated'
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
      flash[:danger] = 'Failed to delete device group.'
    end
    redirect_to account_device_groups_path
  end

  private

  def device_group_params
    params.require(:device_group).permit(:name, :description)
  end

  def collection
    current_organization.device_groups
  end

  def resource
    collection.find(params[:id])
  end
end
