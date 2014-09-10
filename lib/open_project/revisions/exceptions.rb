module OpenProject::Revisions

    class ShellError < StandardError
      attr_reader :command
      attr_reader :output

      def initialize(command, output)
        @command = command
        @output  = output
      end

      def to_s
        "ScmException(#{@command}) -> #{@output}"
      end
    end
end