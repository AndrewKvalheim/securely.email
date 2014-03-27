class MetaController < ApplicationController
  def index
    expires_in 1.year, public: true

    render layout: 'landing'
  end
end
