# frozen_string_literal: true



typed_writer.ignore_always << %w[der die das den des ein eine]

player >> location(:alley)

typed_writer.run do
  print "\n>> "
  print player.process gets chomp: true
end
