class GithubService

  def initialize(username)
    @username = username
  end

  def get_followers
    to_json("/users/#{@username}/followers")
  end

  def get_following
    to_json("/users/#{@username}/following")
  end

  def get_repositories
    to_json("/users/#{@username}/repos")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.params['access_token'] = ENV['GITHUB_TOKEN']
      faraday.adapter  Faraday.default_adapter
    end
  end

  def to_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
