# frozen_string_literal: true


class ActionObject
  attr_reader :names, :ignore

  def initialize(names:, ignore:, action:)
    @names = names
    @ignore = ignore
    @action = case action
              when String then proc { action }
              when Proc then action
              end
  end

  def call(context)
    context.instance_eval @action
  end
end
