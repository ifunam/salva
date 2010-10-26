module Rails
  module Generators
    class GeneratedAttribute
      def field_type
        @field_type ||= case type
          when :text, :integer, :float, :decimal then :string
          when :time                      then :time_select
          when :datetime, :timestamp      then :datetime_select
          when :date                      then :date_select
          when :boolean                   then :radio_button
          when :references                then :collection_select
          else
            :string
        end
      end
      
    end
  end
end