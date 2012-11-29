module Uploadify
  module Rails
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield self.configuration
    end

    class Configuration
    private
      def self.callbacks
        [:onCancel, :onClearQueue, :onDestroy, :onDialogClose, :onDialogOpen, :onDisable, :onEnable, :onFallback, :onInit, :onQueueComplete, :onSelectError, :onSelect, :onSWFReady, :onUploadComplete, :onUploadError, :onUploadSuccess, :onUploadProgress, :onUploadStart]
      end
      def self.value_options
        [:uploader, :buttonClass, :buttonCursor, :buttonImage, :buttonText, :checkExisting, :fileObjName, :fileSizeLimit, :fileTypeDesc, :fileTypeExts, :height, :method, :progressData, :queueID, :queueSizeLimit, :removeTimeout, :successTimeout, :uploadLimit, :width, :overrideEvents]
      end
      def self.bool_options
        [:auto, :debug, :multi, :preventCaching, :removeCompleted, :requeueErrors]
      end
    public
      self.callbacks.each { |option|
        attr_accessor option
      }
      self.value_options.each { |option|
        attr_accessor option
      }
      self.bool_options.each { |option|
        attr_accessor option
      }
      attr_accessor :formData

      if defined?(FlashCookieSession)
        def uploadify_options protection_token, cookies, auth_token
          generate_option_hash do |option_hash|
            option_hash[:formData] = required_form_data(protection_token, cookies, auth_token).merge(@formData || {})
          end
        end
      else
        def uploadify_options
          generate_option_hash do |option_hash|
            option_hash[:formData] = @formData unless @formData.nil?
          end
        end
      end

    private
      def generate_option_hash &block
        validate_options
        @option_hash = {}
        insert_options self.class.value_options
        insert_options self.class.bool_options
        insert_options self.class.callbacks.each do |k,v|
          @option_hash[k] = "_____#{k}____"
        end
        yield @option_hash
        @json = @option_hash.to_json
        set_callbacks_without_quotes
        @json.html_safe
      end

      def validate_options
        raise "UploadifyRails.Configuration.formData must be a hash" unless @formData.is_a?(Hash) || @formData.nil?
        raise "UploadifyRails.Configuration.overrideEvents must be a Array" unless @overrideEvents.is_a?(Array) || @overrideEvents.nil?
        raise "UploadifyRails.Configuration.progressData must be either :percentage or :speed" unless @progressData.nil? || [:percentage, :speed].include?(@progressData.to_sym)
        raise "UploadifyRails.Configuration.buttonCursor must be either :arrow or :hand" unless @buttonCursor.nil? || [:arrow, :hand].include?(@buttonCursor.to_sym)
        raise 'Please set UploadifyRails.Configuration.uploader to the route of the uploading action.  Run `rake routes` to find the correct value' if @uploader.nil?
        self.class.bool_options.each { |bool_option|
          raise "UploadifyRails.Configuration.#{bool_option} must be either 'true' or 'false'" unless [true, false, nil].include?(get_value(bool_option))
        }
      end
      def set_callbacks_without_quotes
        insert_options self.class.callbacks.each do |k,v|
          @json.gsub!("\"#{@option_hash[k]}\"", v)
        end
      end
      def get_value option
        self.instance_variable_get("@#{option}")
      end
      def required_form_data protection_token, cookies, auth_token
        @session_key ||= ::Rails.application.config.session_options[:key]
        @forgery_token = protection_token
        {
          :_http_accept  => 'application/javascript',
          :_method       => 'post',
          @session_key   => cookies[@session_key],
          @forgery_token => auth_token
        }
      end
      def insert_options keys
        keys.each do |option|
          value = get_value(option)
          value = value.call if value.is_a?(Proc)
          unless value.nil?
            if block_given?
              yield option, value
            else
              @option_hash[option] = value
            end
          end
        end
      end
    end
  end
end
