require 'sinatra'
require 'httparty'
require 'rss'

get '/:user' do
  xml = File.read('posts.rss') if File.exist?('posts.rss')
  xml ||= HTTParty.get("https://www.reading.am/#{params[:user]}/posts.rss").body
  feed = RSS::Parser.parse(xml)
  erb :rss, locals: {
      items: feed.items,
      user: params[:user]
  }
end

get '/' do
  'Hello World'
end