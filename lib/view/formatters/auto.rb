module View

  class Auto < Formatter

    def to_s
      if as
        format
      else
        guess
      end
    end

    def datetime_format?
      value.respond_to?(:strftime)
    end

    def file_link_format?
      View.file_methods.any? { |method| value.respond_to?(method) }
    end

    def boolean_format?
      value == true || value == false
    end

    def nil_format?
      value.nil?
    end

    def sentence_format?
      value.respond_to?(:to_sentence)
    end

    def link_format?
      all_options[:to]
    end

    def as
      %w|nil boolean file_link datetime sentence link|.find { |type| send("#{type}_format?") }
    end

    def guess
      View.guessing_methods.each do |method|
        return value.send(method) if value.respond_to?(method)
      end
    end

  end

end
