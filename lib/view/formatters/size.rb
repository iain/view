module View

  class Size < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter ]

    def format
      template.number_to_human_size(value, options)
    end

  end

end
