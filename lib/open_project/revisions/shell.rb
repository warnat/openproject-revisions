require 'open3'

module OpenProject::Revisions
  module Shell

    def self.logger
      Rails.logger
    end

    # Executes the given command and a list of parameters on the shell
    # and returns the result.
    #
    # If the operation throws an exception or the operation yields a non-zero exit code
    # we rethrow a +ShellError+ with a meaningful error message.
    def self.capture_out(command, *params)
      output, err, code = capture(command, *params)
      if code != 0
        error_msg = "Non-zero exit code #{code} for `#{command} #{params.join(" ")}`"
        logger.error(error_msg)
        logger.debug("Error output is #{err}")
        raise ShellError.new(command, error_msg)
      end

      output
    end


    # Executes the given command and a list of parameters on the shell
    # and returns stdout, stderr, and the exit code.
    #
    # If the operation throws an exception or the operation we rethrow a
    # +ShellError+ with a meaningful error message.
    def self.capture(command, *params)
      Open3.capture3(command, *params)
    rescue => e
      error_msg = "Exception occured executing `#{command} #{params.join(" ")}`: #{e.message}"
      logger.error(error_msg)
      raise ShellError.new(command, error_msg)
    end
  end
end
