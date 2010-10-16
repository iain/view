module View

  # Creates a simple definition list for an object.
  # This works well with ActiveRecord objects.
  # Without a block it will render all fields. You can specify the fields
  # using the `fields` option.
  #
  # You can use a block, to further format the way the definition items are
  # formatted.
  #
  # @example Without a block
  #
  #   = view @post, :as => :definition_list, :fields => [ :title, :author ]
  #
  # @example With a block
  #
  #   = view @post, :as => :definition_list do |dl|
  #     = dl.view :title
  #     = dl.view :author
  #     = dl.view :published_at, :as => :date
  #
  class DefinitionList < Formatter

    self.reserved_options = [ :fields ]

    # This will add the dt and dd tags.
    #
    # @param [Symbol] attribute The name of the attribute to be called on +value+
    # @param [Hash] options These will be delegated to the formatting of the
    #   attribute's value.
    # @yield [formatter] The block will be used for formatting the attribute's
    #   value
    def view(attribute, options = {}, &block)
      tag = Attribute.new(value, attribute, block, template, options)
      tag.dt + tag.dd
    end

    protected

    def format!
      template.content_tag(:dl, super, options)
    end

    def format
      unless block
        fields.inject("".html_safe) do |html, field|
          html << view(field)
        end
      end
    end

    def fields
      all_options[:fields] || all_fields
    end

    private

    def all_fields
      value_class.respond_to?(:column_names) ? value_class.column_names : []
    end

    def value_class
      value.class
    end

    # Helper class for definition lists
    class Attribute < Struct.new(:resource, :attribute, :block, :template, :options)

      def dt
        tag :dt, name
      end

      def dd
        tag :dd, value
      end

      private

      def tag(type, value)
        template.content_tag(type, value, html_options)
      end

      def name
        if klass.respond_to?(:human_attribute_name)
          klass.human_attribute_name(attribute)
        else
          attribute.to_s.titleize
        end
      end

      def klass
        resource.class
      end

      def value
        View.format(original_value, options, template, &block)
      end

      def original_value
        resource.send(attribute)
      end

      def html_options
        { :class => attribute }
      end

    end

  end
end
