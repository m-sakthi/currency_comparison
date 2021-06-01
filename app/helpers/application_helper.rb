module ApplicationHelper
  def fetch_data(url) 
    req_url = URI(url)

    http = Net::HTTP.new(req_url.host, req_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(req_url)
    response = http.request(request)
    JSON.parse(response.read_body)
  end

  def str_to_epoch(dt)
    Time.strptime(dt, "%Y-%m-%d").to_i * 1000
  end
end
