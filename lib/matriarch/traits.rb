module Matriarch

  class TraitMethod < Proc
    attr_accessor :container

    def initialize(container, returns=nil, &block)
      super(&block)
      @returns   = returns
      @container = container
    end

    def call(object, *arguments, &block)
      #object.send(:define_method, &self)
      object.instance_eval(&self)  # need instance_exec
    end

    def return! ; @returns = true ; end

    def return? ; @returns ; end
  end

  class TraitEvent
    attr_accessor :input
    attr_accessor :output
    attr_accessor :method
  end

  # Traits never change an interface!!!!!!!!!!

  class TraitsObject

    class << self

      def traits
        @traits ||= Hash.new{|h,k| h[k]=[]}
      end

      # Define a post-positioned trait/method.

      def to(name, returns=nil, &action)
        name  = name.to_sym
        chain = traits[name]

        if chain.empty?
          define_method(name) do |*a|  #&b|
            trait.input = a  # oringal input
            chain.each do |tm|
              trait.output = tm.call(self, *a) #, &b)
              trait.method = tm
              break if tm.return?
            end
            return trait.output
          end
        end

        chain << TraitMethod.new(self, returns, &action)
      end

      # Define a pre-positioned trait/method.

      def prior_to(name, returns=nil, &action)
        name  = name.to_sym
        chain = traits[name]

        if chain.empty?
          define_method(name) do |*a|  #&b|
            trait.input = a  # oringal input
            chain.each do |tm|
              triat.output = tm.call(self, *a) #, &b)
              trait.trait  = tm
              break if tm.return?
            end
            return trait.output
          end
        end

        chain.unshit(TraitMethod.new(self, returns, &action))
      end

      # Use traits
      def include_traits(klass)
        klass.traits.each do |name, chain|
          traits[name].concat(chain)
        end
      end

      # prepend traits
      def prepend_triats(klass)
        klass.traits.each do |name, chain|
          traits[name].replace(chain + traits[name])
        end
      end

      # Remove a traits
      def remove_traits(klass)
        traits.each do |name, chain|
          chain.delete_if do |tm|
            tm.container == klass
          end
        end
      end

    end

    # ok. I know it's not thread-safe, but for now...
    def trait
      @triat ||= TraitEvent.new()
    end

  end

end

