class Account::UsersController < Account::AccountController
  include Account::UsersHelper

  def index
    @users = collection.by_name.page(params[:page]).per(10)
  end

  def show
    @user = resource
  end

  def new
    @user = User.new
  end

  def edit
    @user = resource
    redirect_to account_user_path(@user) unless has_access_to_edit_super_admin?
  end

  def create
    @user = User.new(users_params)
    @user.organization_id = current_organization.id unless current_user.super_admin?
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
      sign_in(current_user, bypass: true)
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

  private

  def users_params
    permitted = [:first_name, :last_name, :email, :avatar, :password, :role]
    if (!current_user.super_admin? && params[:user][:role] == User::SUPER_ADMIN) ||
       !has_access_to_edit_super_admin?
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
