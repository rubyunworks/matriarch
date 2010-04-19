require './supertraits.rb'

  class C < TraitsObject
    to :jump do
      puts "jump C!"; p self
    end
  end

  c = C.new
  c.jump

  puts "---"

  class T < TraitsObject
    to :jump do
      puts "jump T!"; p self
    end
  end

  class C
    include_traits T
  end

  c = C.new
  c.jump
