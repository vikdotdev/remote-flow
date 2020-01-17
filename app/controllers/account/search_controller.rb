class Account::SearchController < Account::AccountController
  def search
    byebug
    @search_results = Elasticsearch::Model.search(params[:q]).page(params[:page]).per(15)
  end
  
  # private
  #
  # def search_params
  #   params.require(:search).permit(:q)
  # end
end
