require 'uploadify-rails/callback_generator'

namespace :uploadify_rails do
  desc "create uploadify.js.coffee in app/assets/javascripts with a skeleton of all Uploadify callbacks"
  task :coffee do
    Uploadify::Rails::CallbackGenerator.new.create_coffeescript_file
  end
end
