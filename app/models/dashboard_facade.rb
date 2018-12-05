class DashboardFacade
  def initialize(user)
    @user = user
  end

  def repos
    @repos ||= github_service.get_repositories.map do |repo|
      Repository.new(repo)
    end
    @repos.sort_by {|repo| repo.name }
  end

  def followers
    @followers ||= github_service.get_followers.map do |f|
      GithubUser.new(f)
    end
    @followers.sort_by{ |f| f.login.downcase}
  end

  private
  attr_reader :user

  def github_service
    GithubService.new(user.token)
  end
end
