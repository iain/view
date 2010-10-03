module View

  class Datetime < Formatter

    def to_s
      ::I18n.l(value, options) if value.present?
    end

  end

end
