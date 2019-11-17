class Account::UsersController < Account::AccountController
  before_action :authenticate_user!
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = resource
  end

  def edit
    @user = resource
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
    @user.destroy
    redirect_to  account_user_path
  end

  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :role, :email, :avatar)
  end

  def resource
    User.find(params[:id])
  end
end
