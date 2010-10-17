module View

  # Formats with the number_to_phone helper
  class Phone < Formatter

    self.allowed_options = [ :area_code, :delimiter, :extension, :country_code ]

    def format
      template.number_to_phone(value, options)
    end

  end

end
