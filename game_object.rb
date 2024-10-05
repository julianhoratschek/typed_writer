# frozen_string_literal: true

require_relative 'action_object'

class GameObject
  def initialize(args)
    @internal_id = args[:internal_id]
    @names = FlatArray.new(args[:names])
    @actions = {}
    _register_action_objects(args[:actions])
  end

  def method_missing(name, *, **)
    @actions[name]&.call(self)
  end


  private


  def _register_action_objects(actions)
    return unless actions

    actions.each_pair do |name, action|
      case action
      when String then self.class.define_method(name, proc { action })
      when Proc then self.class.define_method(name, action)
      when Hash
        @actions[name] = ActionObject.new(names: action[:names], ignore: action[:ignore], action: action[:action])
      end
    end
  end


  protected




  public


  def present?
    true
  end
end
