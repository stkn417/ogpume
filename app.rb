require 'sinatra'
require 'slim'
require 'open-uri'
require 'nokogiri'
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

    if page
      @title = page.title
      @code = "<img src=\"#{page.image}\"/>\n\n<strong>#{page.title}</strong>\n\n<a href=\"#{@link}\">#{@link}</a>"
    else
      @title = title_by_nokogiri
      @code = "<strong>#{@title}</strong>\n\n<a href=\"#{@link}\">#{@link}</a>"
    end

    slim :index
  end

  def title_by_nokogiri
    charset = nil
    html = open(@link) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, 'utf-8')

    # タイトルを表示
    doc.title
  end
end
