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
      config.onUploadSuccess = 'function(data, response){ alert(response); return true; }'
    end

For convenient access to your configuration, add to you ApplicationHelper:

    include UploadifyRailsHelper

You can then access the uploadifier options using `uploadify_rails_options` in a view.  For example:

    <script type='text/javascript'>
      $(document).ready(function() {
        $('input#uploadify').uploadify(<%= uploadify_rails_options %>);
      });
    </script>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
