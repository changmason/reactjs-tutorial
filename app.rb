require 'sinatra'
require 'json'

class Comment

  def self.all
    read_from_json
  end

  def self.push(comment)
    write_to_json(self.all.push(comment))
    self.all
  end

  private

  def self.filepath
    @filepath ||= File.dirname(__FILE__) + '/comments.json'
  end

  def self.read_from_json
    File.exist?(filepath) ? JSON.parse(File.read(filepath)) : []
  end

  def self.write_to_json(data)
    File.open(filepath, 'w') { |f| f.puts(data.to_json) }
  end
end


get '/' do
  erb :index
end

get '/comments.json' do
  Comment.all.to_json
end

post '/comments.json' do
  Comment.push(params).to_json
end