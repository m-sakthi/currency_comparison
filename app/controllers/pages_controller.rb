class PagesController < ApplicationController
  def index
  end

  def compare_currency
    if params[:to_currency].blank?
      render json: { error: "Missing Required param to_currency." }, status: :bad_request
    else
      # api.frankfurter.app is a public api for currency conversion. For more info https://www.frankfurter.app/ 
      url = "https://api.frankfurter.app/2021-05-01..?from=BRL&to=#{params[:to_currency]}"

      res = fetch_data(url)
      res["rates"] = res["rates"].keys
        .map{ |dt| [str_to_epoch(dt), res["rates"][dt][params[:to_currency]]] }

      render json: { results: res }, status: :ok
    end
  end
end
