require 'matriarch'

  class C < Matriarch::TraitsObject
    to :foo do
      "C"
    end
  end

  c = C.new
  p c.foo

  puts "---"

  class T < Matriarch::TraitsObject
    to :foo do
      p trait
      "T"
    end
  end

  class C
    include_traits T
  end

  c = C.new
  p c.foo
