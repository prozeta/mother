module Mother
  module Maestro
    class Controller

      def initialize (config, stage)
        @maestro_path = "/usr/local/bin/maestro"
        @config = config
        @stage = stage
      end

      def yaml
        output = self.header
        output.merge!({ "ships" => self.ships, "services" => self.services })
        output
      end

      def header
        {
          "__maestro" => {
            "schema" => 2
          },
          "ship_defaults" => {
            "timeout" => 30
          }
        }
      end

      def ships
        @ships ||= @config[:nodes].map { |node| { node[:name] => { "ip" => node[:ip].split('/')[0] } } }
      end

      def services
        # @services ||=
      end

      def run
        system("bash -c '#{@maestro_path} -f <(echo #{self.yaml})'")
      end

    end
  end
end