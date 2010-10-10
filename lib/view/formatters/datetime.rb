module View

  # Uses I18n to format a datetime object.
  class Datetime < Formatter

    def format
      ::I18n.l(value, options)
    end

  end

end
