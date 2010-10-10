module View

  class Precision < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter ]

    def format
      template.number_with_precision(value, options)
    end

  end

end
