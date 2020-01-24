class Account::ContentsController < Account::AccountController
  before_action :set_paper_trail_whodunnit

  def index
    @q = collection.ransack(params[:q])
    @contents = @q.result.by_title.page(params[:page]).per(10)
  end

  def show
    @content = resource
    set_meta_tags title: @content.title
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
      flash[:success] = 'Content successfully created.'
      redirect_to account_content_path(@content)
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
    permitted = %i[title type]
    permitted << :video_url if params[:content][:type] == Content::VIDEO
    permitted << :body if params[:content][:type] == Content::PAGE
    permitted << :file if params[:content][:type] == Content::PRESENTATION

    params.require(:content).permit(*permitted)
  end

  def collection
    current_organization.contents
  end

  def resource
    collection.find(params[:id])
  end
end
