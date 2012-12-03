require 'rails/generators'
require 'rails/generators/base'

module Uploadify
  module Rails
    class CallbackGenerator < ::Rails::Generators::Base
      COFFEESCRIPT_FILE = 'uploadify-rails.js.coffee'
      source_root File.expand_path("../../templates", __FILE__)

      def create_coffeescript_file
        puts "Creating coffeescript file..."
        copy_file COFFEESCRIPT_FILE, ::Rails.application.config.root + 'app' + 'assets' + 'javascripts' + COFFEESCRIPT_FILE
        puts "Done!"
      end
    end
  end
end
