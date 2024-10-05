# frozen_string_literal: true


require_relative 'search_string'
require_relative 'none_class'

class ActionObject
  attr_reader :internal_id

  def initialize(internal_id:, names:, ignore:, split:, action:)
    @internal_id = internal_id
    @names = names
    @ignore = ignore
    @split = split
    @action = case action
              when String then proc { action }
              when Proc then action
              end
  end

  def call(context)
    context.instance_eval @action
  end

  def get_objects(context, args)
    args -= @ignore
    return [SearchString.new(context, args.join(' ')), none_class] unless @split

    idx = args.index { |word| @split.include? word }
    [SearchString.new(context, args[0...idx].join(' ')), SearchString.new(context, args[(idx + 1)..].join(' '))]
  end

  def matches?(name)
    @names.include? name
  end

  alias === matches?
end
