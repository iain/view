module View

  # Delegate rendering to the number_to_currency helper from Rails.
  # @see http://rubydoc.info/docs/rails/3.0.0/ActionView/Helpers/NumberHelper:number_to_currency
  class Currency < Formatter

    self.allowed_options = [ :precision, :unit, :separator, :delimiter, :format, :locale ]

    def format
      template.number_to_currency(value, options)
    end

  end

end
