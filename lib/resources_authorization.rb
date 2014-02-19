require "resources_authorization/version"


module ResourcesAuthorization
  autoload :ResourceIdentifer, 'resources_authorization/resource_identifer'
  autoload :Manager, 'resources_authorization/manager'
end

class Object
  def to_resource_identifer
    ResourcesAuthorization::ResourceIdentifer.co(self)
  end
end

