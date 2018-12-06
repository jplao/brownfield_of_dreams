class DashboardFacade
  def initialize(user)
    @user = user
  end

  def following
    @github_following ||= github_service.get_following.map do |github_user|
      GithubUser.new(github_user)
    end
  end

  def repos
    @repos ||= github_service.get_repositories.map do |repo|
      Repository.new(repo)
    end
    @repos.sort_by {|repo| repo.name }
  end

  private
  attr_reader :user

  def github_service
    GithubService.new(user.token)
  end
end
