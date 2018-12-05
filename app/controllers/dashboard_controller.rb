class DashboardController < ApplicationController
  def show
    @github_data = DashboardFacade.new(current_user)
  end
end
