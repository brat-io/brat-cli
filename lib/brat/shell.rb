require 'brat'
require 'brat/help'
require 'brat/cli_helpers'
require 'readline'

class Brat::Shell
  extend Brat::CLI::Helpers

  def self.start
    actions = Brat.actions

    comp = proc { |s| actions.map(&:to_s).grep(/^#{Regexp.escape(s)}/) }

    Readline.completion_proc = comp
    Readline.completion_append_character = ' '

    client = Brat::Client.new(endpoint: '')

    while buf = Readline.readline("brat> ", true)
      next if buf.nil? || buf.empty?
      buf = buf.split.map(&:chomp)
      cmd = buf.shift
      args = buf.count > 0 ? buf : []

      if cmd == 'help'
        methods = []

        actions.each do |action|
          methods << {
            name: action.to_s,
            owner: client.method(action).owner.to_s
          }
        end

        args[0].nil? ? Brat::Help.get_help(methods) : Brat::Help.get_help(methods, args[0])
        next
      end

      data = if actions.include?(cmd.to_sym)
        confirm_command(cmd)
        brat_helper(cmd, args)
      else
        "'#{cmd}' is not a valid command.  See the 'help' for a list of valid commands."
      end

      output_table(cmd, args, data)
    end
  end
end
