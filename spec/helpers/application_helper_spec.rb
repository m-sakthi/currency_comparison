require "spec_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#fetch_data" do
    it "returns the data fetched from the api url" do
      start_date = Date.strptime('2021-05-01', '%Y-%m-%d')

      url = "https://api.frankfurter.app/#{start_date.to_s}..?from=BRL&to=USD"
      res = helper.fetch_data(url)
      
      expect(res).to include('amount')
      expect(res).to include('base')
      expect(res).to include('end_date')
      expect(res).to include('rates')
      expect(res).to include('start_date')

      expect(res['amount']).to eq(1.0)
      expect(res['base']).to eq('BRL')

      # Start day is always monday
      first_week_day_of_month = start_date.next_week unless start_date.monday?
      expect(res['start_date']).to eq(first_week_day_of_month.to_s)

      expect(res['rates'][first_week_day_of_month.to_s]).to include('USD')
    end
  end

  describe "#str_to_epoch" do
    it "returns the epoch timestamp of the date string" do
      expect(helper.str_to_epoch('2021-05-28')).to eq(1622140200000)
    end
  end
end