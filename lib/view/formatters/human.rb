module View

  # The number_to_human helper was introduced in Rails 3.
  # It will give results like "10 thousand"
  class Human < Formatter

    self.allowed_options = [ :locale, :precision, :significant, :separator, :delimiter,
      :strip_insignificant_zeros, :units, :format ]

    def format
      template.number_to_human(value, options)
    end

  end

end
