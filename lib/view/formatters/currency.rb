module View

  class Currency < Formatter

    self.allowed_options = [ :precision, :unit, :separator, :delimiter, :format ]

    def to_s
      template.number_to_currency(value, options)
    end

  end

end
