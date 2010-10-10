module View

  # @abstract Subclass this for html safe lists with formatted each support.
  class List < Formatter

    def to_s
      if all_safe?
        super.html_safe
      else
        super
      end
    end

    def all_safe?
      formatted_values.all? do |element|
        element.respond_to?(:html_safe?) && element.html_safe?
      end
    end

    def formatted_values
      @formatted_values ||= value.map do |element|
        View.format(element, each, template, &block)
      end
    end

    def each
      all_options[:each] || { :as => View.default_formatter }
    end

  end

end
