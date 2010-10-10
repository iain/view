module View

  # The default formatter for blank objects, like nil, empty strings and empty
  # arrays. It will display an empty string or something else, which you can
  # configure with I18n.
  #
  # @example config/locales/en.yml
  #   en:
  #     view:
  #       blank: "nothing"
  #
  class Blank < Formatter

    def format
      ::I18n.t(:blank, :scope => :view, :default => "").html_safe
    end

  end

end
