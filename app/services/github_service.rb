class GithubService

  def followers(username)
    to_json("/users/#{username}/followers?access_token=#{ENV["GITHUB_TOKEN"]}")
  end

  # def following
  # end

  def get_repositories(username)
    to_json("/users/#{username}/repos?access_token=#{ENV["GITHUB_TOKEN"]}")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com")
  end

  def to_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
