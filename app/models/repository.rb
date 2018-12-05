class Repository
  attr_reader :id,
              :name,
              :url

  def initialize(repo_data)
    @id   = repo_data[:id]
    @name = repo_data[:name]
    @url  = repo_data[:url]
  end
end
