# Dynamic Field Format Filter Plugin
# @author Otto Yiu <otto@live.ca>
#
# This plugin allows to extract a single key from an existing event and use the value to re-parse it as the given format,
# and then re-emit a new event with the parsed event
#
require 'fluent/filter'

module Fluent
    class DynamicFormatField < Filter
        Fluent::Plugin.register_filter("dynamic_format", self)

        desc "The key for the format regex"
        config_param :log_format_key, :string, default: "kubernetes_annotations_log_format"
        desc "The key for the log message"
        config_param :key, :string, default: "log"

        def initialize
            super
            @formatter_map = Hash.new
        end

        def configure(conf)
            super
            @configuration = conf
        end


        def filter(tag, time, record)
            if record.has_key? @log_format_key
                format_value = record[@log_format_key]
                log.info(format_value)
                if @formatter_map.has_key? format_value
                    parser = @formatter_map[format_value]
                else
                    parser = Fluent::Plugin.new_parser(format_value)
                    parser.configure(@configuration)
                    @formatter_map[format_value] = parser
                end

                if record.has_key? @key then
                    raw_log_value = record[@key]
                    new_time, new_values = nil, nil
                    parser.parse(raw_log_value) do |parsed_time, parsed_values|
                        new_time = parsed_time
                        new_values = parsed_values
                    end

                    if new_values then
                        new_record = record.merge(new_values)
                        return new_record
                    end
                end

            end

            record

        end
    end
end
