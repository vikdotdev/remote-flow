class Account::DashboardController < Account::AccountController
  def index
    @data = Dashboard.new(current_user).data
  end
end
