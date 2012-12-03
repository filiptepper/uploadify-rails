# Uploadify::Rails

Uploadify plugin for Ruby on Rails asset pipeline.

## Installation

Add this line to your application's Gemfile:

    gem 'uploadify-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uploadify-rails

## Usage

Add to your JavaScript pipeline:

    //= require uploadify

Add to you CSS pipeline:

    /*
     *= require uploadify
    */

You can configure options in an initializer.  For example:

    Uploadify::Rails.configure do |config|
      config.uploader        = 'uploads/create'
      config.buttonText      = lambda { I18n.t('uploader.upload_file') }
      config.queueID         = 'uploadify_queue_div'
      config.onUploadSuccess = true
    end

When you define any callbacks as true, you should define a function 'window.UploadifyRails.#{callback}' in your javascript asset files with the appropriate arguments.  For convenience, you can run `rake uploadify_rails:coffee` to generate a coffeescript file with those functions already outlined.  You can delete or leave as-is any functions in that file whose configuration values are not set to true.

For convenient access to your configuration, add to you ApplicationHelper:

    include UploadifyRailsHelper

You can then access the uploadifier options using `uploadify_rails_options` in a view.  For example:

    <script type='text/javascript'>
      $(document).ready(function() {
        $('input#uploadify').uploadify(<%= uploadify_rails_options %>);
      });
    </script>

## Using flash_cookie_session
If uploadify will be sending data back to your Rails application, just put 'gem "flash_cookie_session"' in your Gemfile, BEFORE 'gem "uploadify-rails"'.

(If you are designing a plugin, remember to put 'require "flash_cookie_session"' at the top of your engine file.  Make sure it's included before 'require "uploadify-rails"'.)

In most cases, 'flash_cookie_session' should be in your Gemfile.  However, if uploadify is configured to send data to a different web application, such as, for instance, if you're uploading files directly to Amazon S3, omit flash_cookie_session.  (If you require it for other parts of your application, list it in the Gemfile AFTER "uploadify-rails".)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
