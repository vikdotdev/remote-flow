class Account::ChannelsController < Account::AccountController
  before_action :set_icon, only: %i[create update]
  def index
    @q = collection.ransack(params[:q])
    @channels = @q.result.by_name.page(params[:page]).per(10)
  end

  def show
    @channel = resource
    set_meta_tags title: @channel.name
  end

  def new
    @channel = Channel.new
  end

  def edit
    @channel = resource
  end

  def create
    @channel = Channel.new(channel_params)
    @channel.organization = current_organization
    if @channel.save
      flash[:success] = 'Channel successfully created.'
      redirect_to account_channel_path(@channel)
    else
      flash[:danger] = 'Failed to create channel.'
      render :new
    end
  end

  def update
    @channel = resource
    if @channel.update(channel_params)
      flash[:success] = 'Channel updated'
      redirect_to account_channel_path(@channel)
    else
      flash[:danger] = 'Error updating channel'
      render :edit
    end
  end

  def destroy
    @channel = resource
    if @channel.destroy
      flash[:success] = 'Channel successfully deleted.'
    else
      flash[:danger] = 'Failed to delete channel.'
    end
    redirect_to account_channels_path
  end

  private

  def set_icon
    file = Rails.root.join('public').to_s + params[:channel][:icon].to_s
    params[:channel][:icon] = File.file?(file) ? File.open(file) : nil
  end

  def channel_params
    params.require(:channel).permit(:name, :icon, content_ids: [])
  end

  def collection
    current_organization.channels
  end

  def resource
    collection.find(params[:id])
  end
end
