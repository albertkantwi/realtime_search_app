class HomeController < ApplicationController
  def index
    @search_logs = SearchLog.order(created_at: :desc).limit(10)
  end

  def search
    query = params[:query]
    ip_address = request.remote_ip
    user = current_user || User.create(name: 'Guest') # Create a guest user if not logged in
    SearchLog.create(user:, query:, ip_address:)
    ActionCable.server.broadcast('search_channel',
                                 { html: render_to_string(partial: 'search_log',
                                                          locals: { search_log: SearchLog.new(
                                                            user:, query:, ip_address:
                                                          ) }) })
  end
end
