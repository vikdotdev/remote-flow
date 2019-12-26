class Api::V1::OrganizationController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

  def show
    if current_organization
      render json: current_organization
    else
      head 404
    end
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: @organization
    else
      head :unprocessable_entity
    end
  end

  def update
    if current_organization&.update(organization_params)
      render json: current_organization
    else
      head 404
    end
  end

  def destroy
    if current_organization&.destroy
      head 200
    else
      head 404
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :logo, :logo_cache, :remove_logo)
  end
end