class Account::UsersController < Account::AccountController
  def index
    @users = collection.order(:id).page(params[:page]).per(10)
  end

  def show
    @user = resource
  end

  def new
    @user = User.new
  end

  def edit
    @user = resource
  end

  def create
    @user = User.new(users_params)
    @user.organization_id = current_organization.id if current_user.admin?
    if @user.save
      redirect_to account_user_path(@user)
      flash[:success] = 'User successfully created.'
    else
      render :new
    end
  end

  def update
    @user = resource
    if @user.update(users_params)
      redirect_to account_user_path
      flash[:success] = 'User successfully updated.'
    else
      render :edit
      flash[:danger] = 'Failed to update user.'
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
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :password, :role, :organization_id)
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

  def current_organization
    current_user.organization
  end
end
