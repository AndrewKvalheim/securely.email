class ApplicationController < ActionController::Base
  # Don't prevent CSRF attacks, since we authenticate on every private request
  skip_before_filter :verify_authenticity_token
end
