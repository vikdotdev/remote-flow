class Account::AccountController < ApplicationController
  layout 'account'

  before_action :authenticate_user!
  helper_method :current_organization

  def current_organization
    current_user.organization
  end
end

