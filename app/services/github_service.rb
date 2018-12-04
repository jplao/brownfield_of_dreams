class GithubService
  attr_reader :filter
  def initialize(filter)
    @filter = filter
  end

  def followers
    to_json("/users/#{@filter[:username]}/followers?access_token=#{ENV["GITHUB_TOKEN"]}")
  end

  # def following
  # end

  def get_repositories
    to_json("/users/#{@filter[:username]}/repos?access_token=#{ENV["GITHUB_TOKEN"]}")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com")
  end

  def to_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
