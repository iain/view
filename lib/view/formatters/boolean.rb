module View

  class Boolean < Formatter

    def format
      ::I18n.t(boolean_value.to_s, :scope => [:view, :booleans], :default => default)
    end

    def default
      boolean_value ? "Yes" : "No"
    end

    def boolean_value
      !!value
    end

  end

end
