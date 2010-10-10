module View

  # This formatter just returns itself. It doesn't do anything.
  class Self < Formatter

    skip_blank_formatter

    def format
      value
    end

  end

end
