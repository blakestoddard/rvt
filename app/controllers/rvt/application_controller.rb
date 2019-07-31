module RVT
  class ApplicationController < ActionController::Base
    # Rails 5.2 has this by default. Skip it, as we don't need it for RVT.
    skip_before_action :verify_authenticity_token, raise: false

    include Authenticate

    before_action :prevent_unauthorized_requests!

    private

    def prevent_unauthorized_requests!
      remote_ip = request.remote_ip

      puts remote_ip

      unless remote_ip.in?(RVT.config.whitelisted_ips)
        head :unauthorized
      end
    end
  end
end