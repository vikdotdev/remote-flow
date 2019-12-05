class Account::ContentsController < Account::AccountController
  def index
    @contents = collection.by_title.page(params[:page]).per(10)
  end

  def show
    @content = resource
  end

  def new
    @content = Content.new
    @content.type = params[:type]
  end

  def edit
    @content = resource
  end

  def create
    @content = collection.new(contents_params)
    if @content.save
      redirect_to account_content_path(@content)
      flash[:success] = 'Content successfully created.'
    else
      flash[:danger] = 'Failed to create content.'
      render :new
    end
  end

  def update
    @content = resource
    if @content.update(contents_params)
      redirect_to account_content_path(@content)
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
    redirect_to account_contents_path
  end

  private

  def contents_params
    params.require(:content).permit(:title, :type, :video_url)
  end

  def collection
    current_organization.contents
  end

  def resource
    collection.find(params[:id])
  end
end
