class Account::UsersController < Account::AccountController
  before_action :require_admin_or_super_admin_only
  before_action :require_super_admin_only!, only: [:impersonate]

  def index
    @q = collection.ransack(params[:q])
    @users = @q.result.by_name.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.csv { send_data collection.to_csv, filename: "users-#{Date.today}.csv" }
    end
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
    @user.organization_id = current_organization.id unless current_user.super_admin?
    if @user.save
      redirect_to account_user_path(@user)
      flash[:success] = 'User successfully created.'
    else
      flash[:danger] = 'Failed to create user.'
      render :new
    end
  end

  def update
    @user = resource
    if @user.update(users_params)
      bypass_sign_in current_user
      redirect_to account_user_path(@user)
      flash[:success] = 'User successfully updated.'
    else
      flash[:danger] = 'Failed to update user.'
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

  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to account_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to account_path
  end

  private

  def users_params
    permitted = [:first_name, :last_name, :email, :avatar, :password, :role]
    if !current_user.super_admin? && params[:user][:role] == User::SUPER_ADMIN
      params[:user][:role] = ''
    end

    if current_user.super_admin?
      permitted << :organization_id
    end

    params.require(:user).permit(*permitted)
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
