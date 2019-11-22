class Account::DashboardController < Account::AccountController
  def index
    flash[:error] = "Welcome to the Reflow!"
  end
end
