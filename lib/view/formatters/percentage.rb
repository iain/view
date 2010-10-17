module View

  # Uses the number_to_percentage helper
  class Percentage < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter, :locale,
      :signigicant, :strip_insignificant_zeros ]

    def format
      template.number_to_percentage(value, options)
    end

  end

end
