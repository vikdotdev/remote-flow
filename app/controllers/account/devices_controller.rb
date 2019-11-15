class Account::DevicesController < ApplicationController
  PER_PAGE = 10

  def index
    @devices = Device.all.paginate(page: params[:page], per_page: PER_PAGE)
  end

  # POST takes the record created by new action and attempts to save in into DB
  def create
    @device = Device.new(device_params)
    if @device.save
      flash[:success] = 'Device successfully created.'
      render 'show'
    else
      flash[:danger] = 'Failed to create device.'
      render 'new'
    end
  end

  # GET renders a form suitable for creating a new resource
  def new
    @device = Device.new
    @organizations = Organization.all
  end

  def edit
    @device = Device.find(params[:id])
  end

  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(device_params)
      flash[:success] = 'Device updated'
      render 'show'
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
end

