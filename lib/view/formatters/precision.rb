module View

  class Precision < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter ]

    def to_s
      template.number_with_precision(value, options)
    end

  end

end
