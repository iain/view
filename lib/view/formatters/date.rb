module View

  class Date < Formatter

    def to_s
      ::I18n.l(value.to_date, options) if value.present?
    end

  end

end
