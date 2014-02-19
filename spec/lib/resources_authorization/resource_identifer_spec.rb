require 'spec_helper'

describe ResourcesAuthorization::ResourceIdentifer do
  it 'class identifer' do
    i = ResourcesAuthorization.to_resource_identifer
    r = ResourcesAuthorization::ResourceIdentifer.new(ResourcesAuthorization.to_s)
    i.to_s.should == r.to_s
  end

  it 'instance identifer' do
    i = "asdf".to_resource_identifer
    r = ResourcesAuthorization::ResourceIdentifer.new(String.to_s, 'asdf')
    i.to_s.should == r.to_s
  end

  it 'record instance' do
    u = User.new
    i = u.to_resource_identifer
    r = ResourcesAuthorization::ResourceIdentifer.new(User.name, u.id.to_s)
    i.to_s.should == r.to_s
  end
end

