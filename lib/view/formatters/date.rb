module View

  # Uses I18n to localize a date.
  class Date < Formatter

    def format
      ::I18n.l(value.to_date, options)
    end

  end

end
