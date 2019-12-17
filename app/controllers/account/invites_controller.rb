class Account::InvitesController < Account::AccountController
  before_action :require_admin_only!

  def index
    @invites = collection.includes(:sender).by_creation_date.page(params[:page]).per(10)
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.sender = current_user
    @invite.organization = current_organization

    if @invite.save
      @invite.send_invite_email
      flash[:success] = 'Invite sent to a user.'
      redirect_to account_invites_path
    else
      flash[:danger] = 'Failed to send invite.'
      render :new
    end
  end

  def destroy
    @invite = resource
    if @invite.destroy
      flash[:success] = 'Invitation successfully deleted.'
    else
      flash[:danger] = 'Failed to delete invitation.'
    end
    redirect_to account_invites_path
  end


  private

  def invite_params
    params[:invite][:role] = '' if params[:invite][:role] == User::SUPER_ADMIN

    params.require(:invite).permit(:email, :role)
  end

  def collection
    current_organization.invites
  end

  def resource
    collection.find(params[:id])
  end

end
