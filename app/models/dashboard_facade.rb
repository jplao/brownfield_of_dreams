class DashboardFacade
  def initialize(user)
    @user = user
  end

  def following
    @github_following ||= github_service.get_following.map do |github_user|
      GithubUser.new(github_user)
    end
  end

  def repos(x = 5)
    @repos ||= github_service.get_repositories.map do |repo|
      Repository.new(repo)
    end
    @repos.sort_by {|repo| repo.name }[0...x]
  end

  def followers
    @followers ||= github_service.get_followers.map do |f|
      GithubUser.new(f)
    end
    @followers.sort_by{ |f| f.login.downcase}
  end

  def github_invitee(invitee)
    @invitee_info ||= github_service.get_email(invitee)
  end

  private
  attr_reader :user

  def github_service
    GithubService.new(user.token)
  end
end
