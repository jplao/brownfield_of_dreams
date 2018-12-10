class GithubUser
  attr_reader :uid,
              :login,
              :url

  def initialize(data)
    @uid   = data[:id]
    @login = data[:login]
    @url   = data[:html_url]
  end

  def user_uid_lookup
    User.find_by(uid: self.uid)
  end

end
