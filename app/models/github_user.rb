class GithubUser
  attr_reader :uid,
              :login,
              :url

  def initialize(data)
    @uid   = data[:id]
    @login = data[:login]
    @url   = data[:html_url]
  end
end
