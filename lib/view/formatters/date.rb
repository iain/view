module View

  class Date < Formatter

    def format
      ::I18n.l(value.to_date, options) if value.present?
    end

  end

end
