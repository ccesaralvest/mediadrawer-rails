require "mediadrawer/rails/engine"
require "mediadrawer/s3"
require 'filemagic'
require 'jbuilder'
require "inflections"
require "bootstrap-sass"
require 'rmagick'
require 'open-uri'

module Mediadrawer
  class << self
    def load_config!
      @config = YAML.load_file("#{::Rails.root}/config/mediadrawer.yml")
    end

    def config
      @config
    end
  end

  module Rails
  end
end