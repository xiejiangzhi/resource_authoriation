module ResourcesAuthorization; module Manager
  require 'resources_authorization/manager/abilities'
  require 'resources_authorization/manager/operation'

  def self.included(cls)
    cls.extend(Operation)
    cls.send(:include, Abilities)
  end

end; end

