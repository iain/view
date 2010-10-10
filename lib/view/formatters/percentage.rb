module View

  class Percentage < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter ]

    def format
      template.number_to_percentage(value, options)
    end

  end

end
