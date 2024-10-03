# frozen_string_literal: true


class FlatArray < Array
  def <<(obj)
    if obj.is_a? Array
      concat ob
    else
      super
    end
  end
end
