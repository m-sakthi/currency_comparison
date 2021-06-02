RSpec.describe PagesController, :type => :controller do
  describe "GET compare_currency" do
    it "renders the result" do
      get :compare_currency, params: { to_currency: 'USD' }

      expect(response.status).to eq(200)
      
      resp = JSON.parse(response.body)
      expect(resp).to include('results')

      result = resp['results']
      expect(result).to include('amount')
      expect(result).to include('base')
      expect(result).to include('end_date')
      expect(result).to include('rates')
      expect(result).to include('start_date')
    end

    it "raises error if to_currency param is not present" do
      get :compare_currency

      expect(response.status).to eq(400)
      res = JSON.parse(response.body)

      expect(res).to include('error')
      expect(res['error']).to eq('Missing Required param to_currency.')
    end
  end
end