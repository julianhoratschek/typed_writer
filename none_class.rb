# frozen_string_literal: true

require 'singleton'

class NoneClass
  include Singleton

  def missing_method(_name, *_args, **_nargs)
    nil
  end
end

def none_class
  NoneClass.instance
end
