module View

  class Auto < Formatter

    FORMATS = %W[nil boolean file_link datetime sentence link guess]

    def format
      format!
    end

    private

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
      value.respond_to?(:each)
    end

    def link_format?
      all_options[:to]
    end

    # We can always guess, so this returns true.
    # It is a last resort.
    def guess_format?
      true
    end

    def as
      FORMATS.find { |type| send("#{type}_format?") }
    end

  end

end
