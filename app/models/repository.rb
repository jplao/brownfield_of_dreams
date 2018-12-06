class Repository
  attr_reader :id,
              :name,
              :url

  def initialize(data)
    @id   = data[:id]
    @name = data[:name]
    @url  = data[:html_url]
  end
end
