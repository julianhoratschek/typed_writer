# frozen_string_literal: true


class SearchString < String
  def initialize(context, string, **opt)
    super(string, **opt)
    @context = context
  end

  def here
    @context.location.find self
  end

  def in_inventory
    @context.inventory.find self
  end
end
