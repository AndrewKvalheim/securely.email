class IdentitiesController < ApplicationController
  def show
    @identity = Identity.find_by_slug!(params[:slug])
  end
end
