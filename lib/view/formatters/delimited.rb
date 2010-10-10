module View

  class Delimited < Formatter

    self.allowed_options = [ :separator, :delimiter ]

    def format
      template.number_with_delimiter(value, options)
    end

  end

end
