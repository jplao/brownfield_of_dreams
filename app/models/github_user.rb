class GithubUser
  attr_reader :id,
              :login,
              :url

  def initialize(data)
    @id = data[:id]
    @login = data[:login]
    @url = data[:html_url]
  end
end
