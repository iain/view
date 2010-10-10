module View

  # @abstract Subclass and override {#format} to implement your own formatter.
  class Formatter

    attr_reader :value, :template, :block

    class_inheritable_accessor :default_options
    self.default_options = {}

    class_inheritable_array :reserved_options
    self.reserved_options = [ :as, :block_arguments ]

    class_inheritable_array :allowed_options
    self.allowed_options = []

    # When you inherit from View::Formatter, the formatters goes on the list,
    # but in reverse order, so that newer formatters kan override older ones.
    def self.inherited(formatter)
      super
      formatters.unshift(formatter)
    end

    # Specify your own name for the formatter. By default the name of the class
    # will be used (without any namespacing), but you can override it yourself
    # by calling this method.
    #
    # @example
    #   class SomeStrangeName < View::Formatter
    #     as :real_name
    #   end
    #
    #   View.format @foo, :as => :real_name
    #
    # @param [Symbol] type The new name of the formatter
    def self.as(type)
      @type = type
    end

    # @return [String] the type of the formatter, either set via +.as+ or
    #   automatically deducted from the class name.
    #
    # @see .as
    def self.type
      @type || name.split('::').last.underscore
    end

    # By default, blank values (nil, empty strings, etc), will override any
    # formatter you specified. This way empty values are handled globally.
    # 
    # If you don't want this, you can either turn it off per formatter.
    # Call this method to turn it off.
    #
    # @example
    #   class IHandleMyOwnBlank < View::Formatter
    #     skip_blank_formatter
    #     # etc...
    #   end
    #
    # @see View::Blank
    def self.skip_blank_formatter
      @skip_blank_formatter = true
    end

    # If you didn't specify a format instance method inside specific
    # formatters, this will raise an error.
    #
    # @abstract Subclass and override {#format} to implement your own formatter.
    # @return [String] the formatted value
    def format
      msg = "The '#{self.class.type}' formatter needs to implement the #format method."
      raise NotImplementedError.new(msg)
    end

    # The "safe" options that you can toss around to helper methods.
    #
    # You can specify which methods are "safe" by white listing or black
    # listing. White listing takes precedence over black listing.
    #
    # To access options that are filtered out, use +all_options+.
    # It's generally a good idea to black list options that you use inside your
    # formatter.
    #
    # The options +:as+ and +:block_arguments+ are black listed by default.
    #
    # @example White listing:
    #
    #   class Sentence < View::Formatter
    #     self.allowed_options = [ :words_connector, :last_word_connector ]
    #
    #     def format
    #       value.to_sentence(options)
    #     end
    #   end
    #
    # @example Black listing:
    #
    #   class Link < View::Formatter
    #     self.reserved_options = [ :to ]
    #
    #     def format
    #       template.link_to(value.to_s, all_options[:to], options)
    #     end
    #   end
    #
    # @return [Hash] filtered options
    # @see #all_options
    def options
      default_options.merge(all_options).delete_if do |key, value|
        option_not_allowed?(key)
      end
    end

    # The final result of the formatter, with the block captured if given.
    #
    # If a template is given, use it to capture the block, for maximum
    # integration with ActionView.
    #
    # @return [String]
    def format!
      if block
        captured_value
      else
        to_s
      end
    end

    # @return All options, unfiltered.
    # @see #options
    def all_options
      @options
    end

    # A hook for formatters to override so they can inject code between above
    # the formatting, without all their inherited classes knowing about it.
    def to_s
      format
    end

    private

    def self.skip_blank_formatter?
      @skip_blank_formatter
    end

    def self.format(*args, &block)
      new(*args, &block).send(:formatted_value)
    end

    def self.formatters
      View.formatters ||= []
    end

    def initialize(value, options = {}, template = nil, &block)
      @value    = value
      @options  = options
      @template = template
      @block    = block
    end

    def formatted_value
      formatter_not_found unless formatter
      formatter.new(value, all_options, template, &block).format!
    end

    def template_can_capture?
      template && template.respond_to?(:capture)
    end

    def captured_value
      if template_can_capture?
        captured_value_by_template
      else
        captured_return_value
      end
    end

    def captured_value_by_template
      template.capture(self, *block_arguments, &block)
    end

    def captured_return_value
      block.call(self, *block_arguments)
    end

    def formatter
      blank_formatter || find_formatter
    end

    def formatter_not_found
      formatter_names = self.class.formatters.map { |formatter| formatter.type.to_s }
      raise "Couldn't find the #{as} formatter. Got: #{formatter_names.join(', ')}"
    end

    def find_formatter
      @formatter ||= self.class.formatters.find { |formatter| formatter.type.to_s == as.to_s }
    end

    def option_not_allowed?(key)
      if allowed_options.empty?
        reserved_options.map(&:to_s).include?(key.to_s)
      else
        !allowed_options.map(&:to_s).include?(key.to_s)
      end
    end

    def block_arguments
      all_options[:block_arguments] || []
    end

    def as
      all_options[:as] || View.default_formatter
    end

    def blank_formatter
      Blank if !find_formatter.skip_blank_formatter? && value.blank?
    end

  end

end

Dir[File.expand_path('../formatters/*.rb', __FILE__)].each do |formatter_file|
  require formatter_file
end
