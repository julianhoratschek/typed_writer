# frozen_string_literal: true

require_relative 'actor'

class Player < Actor
  def initialize(**args)
    super
    @current_action = nil
    @that = none_class
    @recipient = none_class
  end

  def action(action_name)
    return @current_action unless action_name

    @current_action = @actions.find { |_name, action| action.matches? action_name }
  end

  def process(line)
    command, *args = line.split.map(&:downcase)
    return unless action(command)

    @that, @recipient = *action.get_objects(self, args)
    action.call(self)
  end
end

def player(internal_id = nil, **args)
  return typed_writer.find(Player, internal_id) if internal_id

  if args
    p = typed_writer.register(Player, args)
    typed_writer.current_player = p unless typed_writer.current_player
  else
    typed_writer.current_player
  end
end
