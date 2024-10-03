# frozen_string_literal: true

require_relative 'actor'

class Player < Actor
  def initialize(**args)
    super
    @that = nil
    @recipient = nil
  end

  def process(line)
    command, *args = line.split.map { |v| v.downcase }
    command = command.to_sym
    @actions[command]
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
