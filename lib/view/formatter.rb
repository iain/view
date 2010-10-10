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

    def initialize(value, options = {}, template = nil, &block)
      @value    = value
      @options  = options
      @template = template
      @block    = block
    end

    def self.inherited(formatter)
      super
      formatters.unshift(formatter)
    end

    def self.formatters
      View.formatters ||= []
    end

    def self.as(type)
      @type = type
    end

    def self.type
      @type || name.split('::').last.underscore
    end

    def self.format(*args, &block)
      new(*args, &block).format!
    end

    def format!
      if block
        captured_value
      else
        formatted_value
      end
    end

    # @abstract Subclass and override {#format} to implement your own formatter.
    def format
      msg <<-MSG.squeeze(' ')
        The only thing a formatter needs to do is implement the #format method.
        If you see this error, you forgot to do that for the #{self.class.type} formatter.
      MSG
      raise NotImplementedError.new(msg)
    end

    def options
      default_options.merge(all_options).delete_if do |key, value|
        option_not_allowed?(key)
      end
    end

    def to_s
      format
    end

    private

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
      template.capture(*block_arguments, &block)
    end

    def captured_return_value
      block.call(*block_arguments)
    end

    def formatted_value
      formatter_not_found unless formatter
      formatter.new(value, all_options, template, &block).to_s
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
      all_options[:block_arguments] || [ formatted_value ]
    end

    def as
      all_options[:as] || View.default_formatter
    end

    def blank_formatter
      Blank if !find_formatter.skip_blank_formatter? && value.send(View.blank_check_method)
    end

    def self.skip_blank_formatter
      @skip_blank_formatter = true
    end

    def self.skip_blank_formatter?
      @skip_blank_formatter && View.always_format_blank
    end

    def all_options
      @options
    end

  end

end

Dir[File.expand_path('../formatters/*.rb', __FILE__)].each do |formatter_file|
  require formatter_file
end
