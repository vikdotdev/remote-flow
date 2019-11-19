class Account::UsersController < Account::AccountController
  before_action :authenticate_user!
  def index
    @users = collection.order(:id).page params[:page]
  end

  def show
    @user = resource
  end

  def edit
    @user = resource
  end

  def create
    @user = User.new(users_params)
    @user.organization_id = current_organization.id unless current_user.super_admin?
    @user.save
    redirect_to account_user_path(@user)
  end

  def update
    @user = resource
    if @user.update(users_params)
      redirect_to account_user_path
    else
      render :edit
    end
  end

  def destroy
    @user = resource
    if @user.destroy
      flash[:success] = 'User successfully deleted.'
    else
      flash[:danger] = 'Failed to delete user.'
    end
    redirect_to account_users_path
  end

  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :role)
  end

  def collection
    if current_user.super_admin?
      User.all
    else
      current_user.organization.users
    end
  end

  def resource
    collection.find(params[:id])
  end
end
