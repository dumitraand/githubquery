class Repository
    attr_accessor :name, :url, :description, :owner

    def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
    end

    def persisted?
        false
    end
end
