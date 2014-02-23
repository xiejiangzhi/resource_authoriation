# ResourcesAuthorization

A resource authorization manager

## Installation

Add this line to your application's Gemfile:

    gem 'resources_authorization'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resources_authorization

Copy model file:

    curl https://raw.github.com/xjz19901211/resource_authoriation/master/templates/ability.rb\
    > myapp/models/ability.rb


## Usage

Give all users ability:

    Ability.can(nil, [Ability::READ], User)


Give specified user ability:

    Ability.can(user, [Ability::WRITE], user)


Disable ability:

    Ability.cannot(user, [Ability::WRITE], Ability)

Can?

    Ability.can?(user, Ability::READ, User) # => nil
    # give
    Ability.can(user, [Ability::READ], User)
    Ability.can?(user, Ability::READ, User) # => true

    # reject
    Ability.cannot(user, [Ability::READ], User)
    Ability.can?(user, Ability::READ, User) # => false


OWN ability:

    Ability.can(user, [Ability::OWN], User)
    Ability.can?(user, Ability::READ, User) # => true
    Ability.can?(user, Ability::WRITE, User) # => true
    Ability.can?(user, 'other', User) # => true

Instace ability:

    Ability.can?(user, Ability::READ, user) # => false
    Ability.can(user, [Ability::READ], user.class)
    Ability.can?(user, Ability::READ, user) # => true

Other owner:

    class Group
      # has_many :users
    end
    group = group.new

    Ability.can(group, Ability::READ, User)
    Ability.can?(group, Ability::READ, User) # => true

## TODO
  Support users group.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
