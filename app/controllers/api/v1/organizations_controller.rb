class Api::V1::OrganizationsController < Api::V1::ApiController

  def show
    @organization = resource

    render json: @organization
  end

  def update
    @organization = resource
    if @organization.update(organization_params)
      render json @organization
    else
      render_error @organization.errors.full_messages[0], :unprocessable_entity
    end
  end

  def organization_params
    params.require(:organization).permit(:name, :logo, :logo_cache, :remove_logo)
  end

  def collection
    Organization.all
  end

  def resource
    collection.where(token: request.headers['token'])
  end
end