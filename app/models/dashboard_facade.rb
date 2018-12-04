class DashboardFacade


  def repos
    service = GithubService.new(filter)
    data = service.get_repositories
  end

  private

  def gh_service
    GithubService.new(filter)
  end
end
