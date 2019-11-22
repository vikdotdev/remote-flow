class Account::DashboardController < Account::AccountController
  def index
    flash[:success] = "Welcome to the Sample App!"
  end
end
