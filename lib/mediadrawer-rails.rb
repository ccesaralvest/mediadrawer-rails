require "mediadrawer/rails/engine"
require "mediadrawer/s3"
require 'jbuilder'
require "inflections"
require "sass-rails"
require "bootstrap-sass"
require "font-awesome-sass"
require 'RMagick'
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
