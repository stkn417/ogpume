require 'sinatra'
require 'slim'
require 'opengraph'

class App < Sinatra::Base
  register Sinatra::Reloader

  get '/' do
    @link = ""
    @code = ""
    slim :index
  end

  post '/' do
    @link = @params[:link]

    page = OpenGraph.fetch(@link)

    @title = page.title
    @code = "#{page.image}\n\n<strong>#{page.title}</strong>\n\n#{@link}"

    slim :index
  end
end
