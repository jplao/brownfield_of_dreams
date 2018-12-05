class DashboardFacade

  def repos(username)
    github_service(username).get_repositories.map do |repo|
      Repository.new(repo)
    end
  end

  private

  def github_service(username)
    GithubService.new(username)
  end
end
