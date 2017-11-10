class Admin::AdminController < ApplicationController
  USERS = { ENV['ADMIN_USERNAME'] => ENV['ADMIN_PASSWORD'] }

  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end
end
