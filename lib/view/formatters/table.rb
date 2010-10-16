module View

  # Renders a table.
  #
  # It uses a partial, which you can find in the gem under
  # app/views/shared/_table.html.erb (and haml).
  #
  # To change the table layout, you can copy the partial to your own
  # application.
  #
  # You can use a block to format attributes, or you can specify them with the
  # fields option and trust them to be properly formatted automatically.
  #
  # If you don't provide a block or fields, it will try to detect your fields
  # automatically.
  #
  # Use the partial option to render a different table partial.
  #
  # When you use :as => :link, it will link to the record, or you specify the
  # path option. Please see the documentation of View::Link for more information.
  #
  # You will need to specify the class option to get a proper table headers
  # when the collection is empty.
  #
  # @example Without a block:
  #
  #   = view @posts, :as => :table, :fields => [ :title, :author ]
  #
  # @example With a block:
  #
  #   = view @posts, :as => :table do |tb|
  #
  #     = tb.view :title, :path => :edit
  #
  #     = tb.view :author do |formatter|
  #       = link_to formatter.to_s, user_path(formatter.value)
  #
  #     = tb.view :published_at
  #
  # @example With a different partial:
  #
  #   = view @posts, :as => :table, :partial => "shared/fancy_table"
  #
  # @example Change the partial globally:
  #
  #   View::Table.partial = "shared/fancy_table"
  #
  # @example Linking a column, without passing a block:
  #
  #   = view @posts, :as => :table, :link => :title
  #
  class Table < Formatter

    class_inheritable_accessor :partial
    self.partial = 'shared/table'

    # This will add the th and td tags.
    #
    # @param [Symbol] attribute The name of the attribute to be called on +value+
    # @param [Hash] options These will be delegated to the formatting of the
    #   attribute's value.
    # @yield [formatter] The block will be used for formatting the attribute's
    #   value
    def view(attribute, options = {}, &block)
      columns << Column.new(attribute, options, block, self)
      nil
    end

    # The columns defined
    # @return [Array]
    def columns
      @columns ||= []
    end

    # Iterates over the collection and yields rows.
    # @yield [Row]
    def each
      value.each_with_index do |resource, index|
        yield Row.new(resource, self, index)
      end
    end

    def resource_class
      all_options[:class] || value.first.class
    end

    protected

    # FIXME duplication with definition_list formatter
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

    def partial
      all_options[:partial] || self.class.partial
    end

    private

    def all_fields
      resource_class.respond_to?(:column_names) ? resource_class.column_names : []
    end

    def format!
      super
      template.render(partial, :table => self)
    end

    class Column < Struct.new(:attribute, :options, :block, :table)

      delegate :resource_class, :to => :table

      # Returns the name of the column.
      # If the record extends ActiveModel::Translations, it will use
      # human_attribute_name, which gets the translations from I18n. Otherwise
      # it will just titleize the name of the attribute.
      def name
        if resource_class.respond_to?(:human_attribute_name)
          resource_class.human_attribute_name(attribute)
        else
          attribute.to_s.titleize
        end
      end

      # Html options to add to your td and th tags.
      # @return [Hash]
      def html_options
        { :class => attribute }
      end

    end

    class Row < Struct.new(:resource, :table, :index)

      # Loops through all columns and yields cells.
      #
      # @yield [Cell]
      def each
        table.columns.each do |column|
          yield Cell.new(self, column)
        end
      end

    end

    class Cell < Struct.new(:row, :column)

      delegate :resource, :table, :to => :row
      delegate :template, :to => :table
      delegate :attribute, :block, :options, :html_options, :to => :column

      # Returns the formatted value for the cell
      def value
        View.format(value_or_resource, options, template, &block)
      end

      private

      def value_or_resource
        link? ? resource : original_value
      end

      def original_value
        resource.send(attribute)
      end

      def all_options
        column.options
      end

      def options
        link_options.merge(all_options)
      end

      def link?
        has_link_options? || global_link_column?
      end

      def global_link_column?
        table.all_options[:link].to_s == attribute.to_s
      end

      def has_link_options?
        all_options[:as] == :link || (!all_options[:as] && all_options[:path])
      end

      def link_options
        link? ? { :text => original_value, :as => :link } : {}
      end

    end

  end

end
