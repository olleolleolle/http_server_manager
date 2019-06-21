class RackApplication

  def initialize
    @ping_count = 0
  end

  def call(env)
    request = Rack::Request.new(env)
    @ping_count += 1 if request.path_info == "/ping"
    response_body = request.path_info == "/ping_count" ? @ping_count.to_s : "OK"
    [ 200, { "Content-Type" => "text/plain" }, [ response_body ] ]
  end

end

run RackApplication.new
