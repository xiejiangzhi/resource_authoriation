class Ability
  include MongoMapper::Document
  include ResourcesAuthorization::Manager


  # Abilities
  READ = 'read'
  WRITE = 'write'
  OWN = 'own'


  key :resource_identifer, String
  
  # ['+read', '-write', '[+-]foo']
  # => can read, cannot write, etc..
  key :abilities, Array
  

  belongs_to :owner, :polymorphic => true

  ensure_index :resource_identifer => 1, :owner_id => 1, :owner_type => 1
end

