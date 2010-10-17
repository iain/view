module View

  # The auto formatter tries to figure out what other formatter should be the
  # most appropriate to use and delegates the formatting to that formatter.
  #
  # This is fully configurable too. See Auto.add
  class Auto < Formatter

    skip_blank_formatter

    # Adds behavior to check which view should automatically be used.
    #
    # @example
    #
    #   View::Auto.add :boolean do
    #     value == true || value == false
    #   end
    #
    # @param [Symbol] formatter_name The name of the formatter
    #
    # @yield The block is eval'd inside the formatter, so you can use the
    #   instance methods that are available for every formatters, like +value+
    #   and +options+.
    #
    # @yieldreturn [true, false] The first block to evaluate to true will
    #   determine the formatter. New blocks are checked first.
    def self.add(formatter_name, &block)
      auto_formatters.unshift(:formatter => formatter_name, :block => block)
    end

    def format
      formatted_value
    end

    private

    def self.auto_formatters
      @auto_formatters ||= []
    end

    def as
      as = self.class.auto_formatters.find { |auto| instance_eval(&auto[:block]) }
      as ? as[:formatter] : :guess
    end

    add View.configuration.default_list_formatter do
      value.respond_to?(:each)
    end

    add :datetime do
      value.respond_to?(:strftime)
    end

    add :file_link do
      View.configuration.file_methods.any? { |method| value.respond_to?(method) }
    end

    add :link do
      all_options.has_key?(:to)
    end

    add :self do
      value.is_a?(String)
    end

    add :blank do
      value.blank?
    end

    add :boolean do
      value == true || value == false
    end

  end

end
