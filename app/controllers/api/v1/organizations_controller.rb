class Api::V1::OrganizationsController < Api::V1::ApiController

  def show
    render json: current_organization
  end

  def index
    render json: current_organization
  end

  def create

  end

  def edit

  end

  def update

  end

end