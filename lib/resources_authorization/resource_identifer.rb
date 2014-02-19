require 'digest'

module ResourcesAuthorization; class ResourceIdentifer
  def initialize(cls_name, id = nil)
    @cls_name = cls_name
    @id = id
  end

  def to_s
    if @id
      "#{@cls_name}.#{@id}"
    else
      @cls_name.to_s
    end
  end


  def self.co(obj)
    if obj_is_class_or_module? obj
      co_class obj
    else
      co_instance obj
    end
  end


  def self.co_class(cls)
    new(cls.name)
  end


  def self.co_instance(obj)
    # is database record? 
    id = if obj.respond_to? :id
      obj.id.to_s
    else
      obj2id(obj)
    end

    new(obj.class.name, id)
  end


  def self.obj2id(obj)
    s = obj.to_s

    if s.length > 128
      Digest::MD5(obj.to_s)
    else
      s
    end
  end


  def self.obj_is_class_or_module?(obj)
    obj.respond_to?(:class_exec) && obj.respond_to?(:constants)
  end
end; end

