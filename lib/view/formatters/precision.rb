module View

  # Format it with the number_with_precision helper
  class Precision < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter,
      :locale, :significant, :strip_insignificant_zeros ]

    def format
      template.number_with_precision(value, options)
    end

  end

end
