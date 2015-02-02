require 'brat'
require 'terminal-table/import'
require_relative 'cli_helpers'
require_relative 'shell'

class Brat::CLI
  extend Helpers

  def self.start(args)
    command = args.shift.strip rescue 'help'
    run(command, args)
  end

  def self.run(cmd, args=[])
    case cmd
    when 'help'
      puts actions_table
    when 'info'
      endpoint = Brat.endpoint ? Brat.endpoint : 'not set'
      private_token = Brat.private_token ? Brat.private_token : 'not set'
      puts "Brat endpoint is #{endpoint}"
      puts "Brat private token is #{private_token}"
      puts "Ruby Version is #{RUBY_VERSION}"
      puts "Brat Ruby Gem #{Brat::VERSION}"
    when '-v', '--version'
      puts "Brat Ruby Gem #{Brat::VERSION}"
    when 'shell'
      Brat::Shell.start
    else
      unless valid_command?(cmd)
        puts "Unknown command. Run `brat help` for a list of available commands."
        exit(1)
      end

      if args.any? && (args.last.start_with?('--only=') || args.last.start_with?('--except='))
        command_args = args[0..-2]
      else
        command_args = args
      end

      confirm_command(cmd)

      data = brat_helper(cmd, command_args) { exit(1) }
      output_table(cmd, args, data)
    end
  end
end
