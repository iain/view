module View

  # @abstract Subclass this for html safe lists with formatted each support.
  class Array < Formatter

    # The formatted value will be html safe if all the elements in the array
    # are safe too.
    def to_s
      result = super
      if result.respond_to?(:html_safe) && all_safe?
        result.html_safe
      else
        result
      end
    end

    def all_safe?
      formatted_values.all? do |element|
        element.respond_to?(:html_safe?) && element.html_safe?
      end
    end

    def formatted_values
      @formatted_values ||= value.map do |element|
        View.format(element, each_options, template, &block)
      end
    end

    def each_options
      all_options[:each] || { :as => View.configuration.default_formatter }
    end

  end

end
