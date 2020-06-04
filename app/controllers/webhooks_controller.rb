class WebhooksController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :verify_authenticity_token
  def complete
    
    render status: 200
  end
  def receive
    
    JSON.parse(request.body.read)
    # coming soon!
    
  end
end
