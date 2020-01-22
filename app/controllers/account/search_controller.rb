class Account::SearchController < Account::AccountController
  def search
    if current_user.super_admin?
      @search_results = Elasticsearch::Model.search(params[:el]).page(params[:page]).per(15)
    else
      @search_results = Kaminari.paginate_array(Elasticsearch::Model.search(params[:el])
        .select{|i| i.organization_id == current_organization.id}).page(params[:page]).per(15)
    end
  end
end
