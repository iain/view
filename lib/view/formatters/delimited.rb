module View

  # Delegate rendering to the number_with_delimiter helper from Rails.
  # @see http://rubydoc.info/docs/rails/3.0.0/ActionView/Helpers/NumberHelper:number_with_delimiter
  class Delimited < Formatter

    self.allowed_options = [ :separator, :delimiter, :locale ]

    def format
      template.number_with_delimiter(value, options)
    end

  end

end
