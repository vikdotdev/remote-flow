class Account::ContentsController < Account::AccountController
  def index
    @contents = collection.page(params[:page]).per(10)
  end

  def show
    @content = resource
  end

  def new
    @content = Content.send(set_type.pluralize).new
  end

  def edit
    @content = resource
  end

  def create
    @content = collection.send(set_type.pluralize).new(contents_params)
    if @content.save
      redirect_to account_organization_video_path(@content.organization, @content)
      flash[:success] = 'Content successfully created.'
    else
      flash[:danger] = 'Failed to create content.'
      render :new
    end
  end

  def update
    @content = resource
    if @content.update(contents_params)
      redirect_to account_organization_video_path(@content)
      flash[:success] = 'Content successfully updated.'
    else
      flash[:danger] = 'Failed to update content.'
      render :edit
    end
  end

  def destroy
    @content = resource
    if @content.destroy
      flash[:success] = 'Content successfully deleted.'
    else
      flash[:danger] = 'Failed to delete content.'
    end
    redirect_to account_organization_videos_path
  end

  private

  def set_type
    case params[:type]
    when 'Video'
      'video'
    end
  end

  def contents_params
    params.require(set_type.to_sym).permit(:type, :video_url)
  end

  def collection
    current_organization.send(set_type.pluralize)
  end

  def resource
    collection.find(params[:id])
  end
end
