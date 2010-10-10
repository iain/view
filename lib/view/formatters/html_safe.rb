module View

  class HtmlSafe < Formatter

    def format
      value.to_s.html_safe
    end

  end

end
