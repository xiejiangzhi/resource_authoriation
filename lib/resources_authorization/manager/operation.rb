module ResourcesAuthorization; module Manager; module Operation
  def can(owner, abilities, resource)
    ability = find_or_new_ability(owner, resource)

    ability.can(*abilities)
    ability.save
  end


  def cannot(owner, abilities, resource)
    ability = find_or_new_ability(owner, resource)

    ability.cannot(*abilities)
    ability.save
  end


  def clear(owner, abilities, resource)
    return unless abilities.length > 0

    ability = find_or_new_ability(owner, resource)
    return if ability.new_record?

    ability.clear(*abilities)
    ability.save
  end


  # true: can
  # false: cannot
  # nil: no defined
  def can?(owner, ability, resource)
    result = find_and_can?(owner, ability, resource)
    return result unless result.nil?

    unless ResourceIdentifer.send(:obj_is_class_or_module?, resource)
      result = find_and_can?(owner, ability, resource.class)
      return result unless result.nil?
    end

    # all owner can?
    can?(nil, ability, resource) unless owner.nil?
  end

private

  def find_or_new_ability(owner, resource)
    attrs = owner_resource_attrs(owner, resource)

    where(attrs).first || new(attrs)
  end


  def owner_resource_attrs(owner, resource)
    attrs = {
      :resource_identifer => resource.to_resource_identifer.to_s
    }
    return attrs unless owner

    attrs.merge!({
      :owner_id => owner.id,
      :owner_type => owner.class.name
    })
  end
  

  def find_and_can?(owner, ability, resource)
    record = where(owner_resource_attrs(owner, resource)).first

    record.can?(ability) if record
  end
end; end; end

