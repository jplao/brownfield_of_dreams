class GithubUser
  attr_reader :id,
              :login,
              :url
              
  def initialize(github_user_data)
    @id = github_user_data[:id]
    @login = github_user_data[:login]
    @url = github_user_data[:url]
  end
end
