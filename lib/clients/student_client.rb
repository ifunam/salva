require 'rest_client'
class StudentClient

  def initialize(login)
    @site = 'https://siesta.fisica.unam.mx/public'
    @url = "#{@site}/students.json?login=#{login}"
    @resource = RestClient::Resource.new @url
  end

  def get
    @resource.get
  end

  def as_json
    JSON.parse(get)
  end

  def all 
    as_json['students']
  end
end
