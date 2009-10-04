
  class Trait
    attr_accessor :container
    attr_accessor :method_name

    def initialize(container, method_name)
      @container   = container
      @method_name = method_name
    end

    def call(object, *arguments, &block)
      object.send(method_name, *arguments, &block)
    end
  end

  class TraitsObject

    class << self

      def traits
p "here"
        @traits ||= Hash.new{ |h,k| h[k] = [] }
      end

      def use(klass)
        klass.traits.each do |name, t|
          traits[name].concat(t)
        end
      end

      def method_added(name)
        return if /^__trait/ =~ name.to_s

        return if method_defined?("__trait_#{name}")

        trait_name = "__trait_#{name}_#{traits.size}"

        traits[name.to_sym] << Trait.new(self, trait_name)

        alias_method trait_name, name

        class_eval %{
          def __trait_#{name}(*a, &b)
            self.class.traits[:'#{name}'].each do |trait|
p trait
              trait.call(self, *a, &b)
            end
          end
        }
        alias_method name, "__trait_#{name}"
      end

    end

  end
