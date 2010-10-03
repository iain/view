module View

  class Size < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter ]

    def to_s
      template.number_to_human_size(value, options)
    end

  end

end
