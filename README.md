# ResourcesAuthorization

A resource authorization manager

## Installation

Add this line to your application's Gemfile:

    gem 'resources_authorization'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resources_authorization

## Usage

* copy templates/ability.rb to models

```

    # all user can read
    Ability.can(nil, [Ability::READ], User)

    # specified user cannot read
    Ability.cannot(user, [Ability::READ], User)

    Ability.can?(user, Ability::READ, User) # => false
    Ability.can?(user.new, Ability::READ, User) # => true
    Ability.can?(user.new, Ability::READ, user) # => true
    Ability.can?(user, Ability::WRITE, User) # => nil (not defined)


    Ability.cannot(group, Ability::READ, User)
    Ability.can?(group, Ability::READ, User) # => false
    Ability.can?(group, Ability::READ, User.new) # => false

```


## TODO

```  

    ri = ResourcesAuthorization::ResourceIdentifer.new('User', user.id)
    Ability.can(user, [Ability::READ], ri)

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
