module View

  class Currency < Formatter

    self.allowed_options = [ :precision, :unit, :separator, :delimiter, :format ]

    def format
      template.number_to_currency(value, options)
    end

  end

end
