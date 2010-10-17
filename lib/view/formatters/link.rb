module View

  # Makes a link of it.
  #
  # The text will be determined by a new formatter.
  #
  # You can specify a url with the `:to` option.
  # You can specify part of the polymorphic_path with `:path`.
  #
  # @example
  #
  #   = view @post, :as => :link
  #   -# equal to
  #   = link_to @post.title, @post
  #
  # @example
  #
  #   = view @post, :as => :link, :path => :edit
  #
  # @example
  #
  #   = view @post, :as => :link, :to => "http://example.com"
  #
  # @example
  #
  #   = view @post, :as => :link, :text => "go to the post"
  #
  class Link < Formatter

    self.reserved_options = [ :to, :path, :text ]

    def format
      template.link_to(text, to, options)
    end

    def to
      all_options[:to] || template.polymorphic_path(automatic_link)
    end

    def automatic_link
      ::Array.wrap(all_options[:path]) + [ value ]
    end

    def text
      all_options[:text] || View.format(value, {:as => :auto}, template)
    end

  end

end
