class Account::DevicesController < ApplicationController
  PER_PAGE = 10

  def index
    @devices = Device.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      flash[:success] = 'Device successfully created.'
      redirect_to account_device_path(@device)
    else
      flash[:danger] = 'Failed to create device.'
      render 'new'
    end
  end

  def new
    @device = Device.new
    @organizations = Organization.all
  end

  def edit
    @device = find_by_id
  end

  def update
    @device = find_by_id
    if @device.update_attributes(device_params)
      flash[:success] = 'Device updated'
      redirect_to account_device_path(@device)
    else
      flash[:danger] = 'Error updating device'
      render 'edit'
    end
  end

  def destroy
    @device = Device.find(params[:id])
    if @device.destroy
      flash[:success] = 'Device successfully deleted.'
    else
      flash[:danger] = 'Failed to delete device.'
    end
  end

  def show
    @device = Device.find(params[:id])
  end

  private

  def device_params
    params.require(:device).permit(:name, :organization_id)
  end

  def find_by_id
    Device.find(params[:id])
  end
end

