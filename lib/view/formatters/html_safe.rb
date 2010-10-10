module View

  # This formatter marks the value as html safe
  class HtmlSafe < Formatter

    def format
      value.to_s.html_safe
    end

  end

end
