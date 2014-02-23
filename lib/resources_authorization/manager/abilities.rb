module ResourcesAuthorization; module Manager; module Abilities

  def can(*target)
    target.each do |a|
      abilities.delete_if {|v| v[1..-1] == a }
      abilities << "+#{a}"
    end
  end


  def cannot(*target)
    target.each do |a|
      abilities.delete_if {|v| v[1..-1] == a }
      abilities << "-#{a}"
    end
  end


  def clear(*target)
    target.each do |a|
      abilities.delete_if {|v| v[1..-1] == a }
    end
  end


  def can?(ability)
    v = abilities.find {|a| a[1..-1] == ability }
    own = _get_own_value
    unless v && own && ability != own
      v = abilities.find {|a| a[1..-1] == own }
    end
    return unless v

    v[0] == '+'
  end


private
  def _get_own_value
    return unless self.class.const_defined?(:OWN)
    self.class.const_get(:OWN)
  end
end; end; end

