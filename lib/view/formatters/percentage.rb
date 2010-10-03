module View

  class Percentage < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter ]

    def to_s
      template.number_to_percentage(value, options)
    end

  end

end
