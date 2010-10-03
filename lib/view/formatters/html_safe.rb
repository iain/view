module View

  class HtmlSafe < Formatter

    def to_s
      value.to_s.html_safe
    end

  end

end
