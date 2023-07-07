# frozen_string_literal: true

require 'sinatra/base'
require 'logger'
require_relative 'converter.rb'

# App is the main application where all your logic & routing will go
class App < Sinatra::Base
  set :erb, escape_html: true
  enable :sessions

  attr_reader :logger

  def initialize
    super
    @logger = Logger.new('log/app.log')
  end

  def title
    'Video Tools'
  end

  def navbar
    {
      "/converter" => ["Converter", ""],
    }
  end

  get '/' do
    logger.info('requsting the index')
    @flash = { info: 'Welcome to Summer Institute!' }
    erb :index
  end

  # Converter

  def converter_formats
    Converter.formats
  end

  get '/converter' do
    erb :converter
  end

  post '/converter' do
    if params[:file]
      filename = params[:file][:filename]
      tempfile = params[:file][:tempfile]
    
      FileUtils.cp(tempfile.path, "files/#{filename}")
    end
  end
end
