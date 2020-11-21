module Authentication
  class Base
    attr_accessor :errors

    def initialize(**args)
      args.symbolize_keys!
      args.keys.each { |key| instance_variable_set("@#{key}", args[key]) }
    end

    def success?
      errors.blank?
    end

    private

      def error(msg)
        I18n.t("errors.#{msg}")
      end
  end
end