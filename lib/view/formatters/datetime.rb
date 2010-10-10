module View

  class Datetime < Formatter

    def format
      ::I18n.l(value, options) if value.present?
    end

  end

end
