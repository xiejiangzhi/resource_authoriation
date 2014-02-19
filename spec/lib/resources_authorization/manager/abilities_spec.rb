require 'spec_helper'

describe ResourcesAuthorization::Manager::Abilities do

  describe 'can' do
    before :each do
      @a = Ability.new
    end

    it 'add empty ability' do
      @a.can(Ability::READ)
      @a.abilities.should == ['+read']
      @a.can(Ability::WRITE)
      @a.abilities.should == ['+read', '+write']
    end

    it 'add exist ability' do
      @a.can(Ability::READ)
      @a.can(Ability::READ)
      @a.abilities.should == ['+read']
    end

    it 'add multiple abilities' do
      @a.can(Ability::READ, Ability::WRITE)
      @a.abilities.should == ['+read', '+write']
    end
  end


  describe 'cannot' do
    before :each do
      @a = Ability.new
      @a.can(Ability::READ, Ability::WRITE)
    end

    it 'reject ability' do
      @a.cannot(Ability::READ)
      @a.abilities.sort.should == ['-read', '+write'].sort
    end

    it 'reject not exist ability' do
      @a.cannot(Ability::OWN)
      @a.abilities.sort.should == ['+read', '+write', '-own'].sort
    end

    it 'reject multiple abilities' do
      @a.cannot(Ability::READ, Ability::WRITE, Ability::OWN)
      @a.abilities.sort.should == ['-read', '-write', '-own'].sort
    end
  end


  describe 'clear' do
    before :each do
      @a = Ability.new
      @a.can(Ability::READ)
      @a.cannot(Ability::WRITE)
    end

    it 'clear can ability' do
      @a.clear Ability::READ
      @a.abilities.should == ['-write']
    end

    it 'clear cannot ability' do
      @a.clear Ability::WRITE
      @a.abilities.should == ['+read']
    end

    it 'clear not exist ability' do
      @a.clear Ability::OWN
      @a.abilities.should == ['+read', '-write']
    end

    it 'clear multiple ability' do
      @a.clear Ability::READ, Ability::WRITE, Ability::OWN
      @a.abilities.should == []
    end
  end

  describe 'can?' do
    before :each do
      @a = Ability.new
      @a.can Ability::READ
      @a.cannot Ability::WRITE
    end

    it 'test can ability' do
      @a.can?(Ability::READ).should == true
    end


    it 'test cannot ability' do
      @a.can?(Ability::WRITE).should == false
    end

    it 'test not exist ability' do
      @a.can?(Ability::OWN).should == nil
    end
  end
end

