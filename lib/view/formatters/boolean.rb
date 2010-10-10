module View

  # The default formatter for booleans.
  #
  # It will display "Yes" or "No".
  #
  # You can configure it with I18n. When writing 'true' and 'false' as keys in
  # yaml, please don't forget the quotes.
  #
  # @example config/locales/en.yml
  #   en:
  #     view:
  #       booleans:
  #         'true': Yup
  #         'false': Nope
  #
  class Boolean < Formatter

    skip_blank_formatter

    def format
      ::I18n.t(boolean_value.to_s, :scope => [:view, :booleans], :default => default)
    end

    def default
      boolean_value ? "Yes" : "No"
    end

    def boolean_value
      !!value
    end

  end

end
