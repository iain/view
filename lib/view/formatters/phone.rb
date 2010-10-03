module View

  class Phone < Formatter

    self.allowed_options = [ :area_code, :delimiter, :extension, :country_code ]

    def to_s
      template.number_to_phone(value, options)
    end

  end

end
