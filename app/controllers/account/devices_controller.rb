class Account::DevicesController < Account::AccountController
  def index
    @devices = collection.by_name.page(params[:page]).per(10)
  end

  def show
    @device = resource
  end

  def new
    @device = Device.new
  end

  def edit
    @device = resource
  end

  def create
    @device = Device.new(device_params)
    @device.organization = current_organization
    if @device.save
      flash[:success] = 'Device successfully created.'
    else
      flash[:danger] = 'Failed to create device.'
    end
  end

  def update
    @device = resource
    if @device.update(device_params)
      flash[:success] = 'Device updated'
    else
      flash[:danger] = 'Error updating device'
    end
  end

  def destroy
    @device = resource
    if @device.destroy
      flash[:success] = 'Device successfully deleted.'
    else
      flash[:danger] = 'Failed to delete device.'
    end
  end

  private

  def device_params
    params.require(:device).permit(:name)
  end

  def collection
    current_organization.devices
  end

  def resource
    collection.find(params[:id])
  end
end
