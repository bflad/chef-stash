actions :create

attribute :alias, :kind_of => String, :name_attribute => true

attribute :key, :kind_of => String, :required => true

attribute :owner, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :create
end
