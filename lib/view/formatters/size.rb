module View

  # Formats with number_to_human_size
  #
  # @example
  #
  #   = view 1999, :as => :size # => "1.95 KB"
  #
  # @see http://rubydoc.info/docs/rails/3.0.0/ActionView/Helpers/NumberHelper:number_to_human_size
  class Size < Formatter

    self.allowed_options = [ :precision, :separator, :delimiter ]

    def format
      template.number_to_human_size(value, options)
    end

  end

end
