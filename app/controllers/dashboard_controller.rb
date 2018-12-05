class DashboardController < ApplicationController
  def show
    if current_user.token == nil
    else
      @github_data = DashboardFacade.new(current_user)
    end
  end
end
