class Account::SearchController < Account::AccountController
  def search
    @search_results = Elasticsearch::Model.search(params[:q]).page(params[:page]).per(1)
  end
end
