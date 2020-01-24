class Api::V1::ContentsController < Api::V1::ApiController
  before_action :set_paper_trail_whodunnit

  def index
    render json: collection
  end

  def show
    render json: resource
  end

  def create
    @content = collection.new(contents_params)

    if @content.save
      render json: @content
    else
      render json: { errors: @content.errors }, status: :unprocessable_entity
    end
  end

  def update
    @content = resource

    if @content.update(contents_params)
      render json: @content
    else
      render json: { errors: @content.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    head 200
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
