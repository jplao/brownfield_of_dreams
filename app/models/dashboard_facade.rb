class DashboardFacade
  def initialize(user)
    @user = user
  end

  def repos
    @repos ||= github_service.get_repositories.map do |repo|
      Repository.new(repo)
    end
  end

  private
  attr_reader :user

  def github_service
    GithubService.new(user.token)
  end
end
