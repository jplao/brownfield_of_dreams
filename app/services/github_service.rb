class GithubService

  def initialize(github_token)
    @github_token = github_token
  end

  def get_followers
    to_json("/user/followers")
  end

  def get_following
    to_json("/user/following")
  end

  def get_repositories
    to_json("/user/repos")
  end

  def get_email(invitee)
    to_json("/users/#{invitee}")
  end

  private
  attr_reader :github_token

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.params['access_token'] = github_token
      faraday.adapter  Faraday.default_adapter
    end
  end

  def to_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
