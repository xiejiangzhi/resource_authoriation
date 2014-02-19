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
    return unless v
    v[0] == '+'
  end

end; end; end

