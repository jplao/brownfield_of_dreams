class DashboardFacade
  def initialize(username)
    @username = username
  end

  def repos
    data = gh_service.get_repositories(@username)
    data[0]
  end

  private

  def gh_service
    GitHubService.new
  end
end
