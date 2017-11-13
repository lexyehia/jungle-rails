require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should have a first_name' do
      @user = User.create(
        first_name: nil,
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )
      expect(User.count).to eq 0
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should have a last_name' do
      @user = User.create(
        first_name: 'John',
        last_name: nil,
        email: 'cy@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )
      expect(User.count).to eq 0
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should have an email' do
      @user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: nil,
        password: 'something',
        password_confirmation: 'something'
      )
      expect(User.count).to eq 0
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should have a password' do
      @user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: nil,
        password_confirmation: 'something'
      )
      expect(User.count).to eq 0
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should have a password confirmation' do
      @user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: 'something',
        password_confirmation: nil
      )
      expect(User.count).to eq 0
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should have a password that matches confirmation' do
      @user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: 'something',
        password_confirmation: 'somethingelse'
      )
      expect(User.count).to eq 0
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should have a password that is at least 5 chars' do
      @user = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: 'some',
        password_confirmation: 'some'
      )
      expect(User.count).to eq 0
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    it 'should have a unique email' do
      @user = User.create!(
        first_name: 'John',
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user2 = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )

      expect(User.count).to eq 1
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should have a unique email regardless of email case' do
      @user = User.create!(
        first_name: 'John',
        last_name: 'Smith',
        email: 'CY@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user2 = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )

      expect(User.count).to eq 1
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should have a unique email regardless of leading or trailing whitespace' do
      @user = User.create!(
        first_name: 'John',
        last_name: 'Smith',
        email: 'cy@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user2 = User.create(
        first_name: 'John',
        last_name: 'Smith',
        email: '  cy@cy.com ',
        password: 'something',
        password_confirmation: 'something'
      )

      expect(User.count).to eq 1
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return nil if no user found by email' do
      User.create!(
        first_name: 'John',
        last_name: 'Smith',
        email: 'CY@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user = User.authenticate_with_credentials('bb@cy.com', 'something')
      expect(@user).to eq nil
    end

    it 'should return nil if password is wrong' do
      User.create!(
        first_name: 'John',
        last_name: 'Smith',
        email: 'CY@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user = User.authenticate_with_credentials('cy@cy.com', 'somethingelse')
      expect(@user).to eq nil
    end

    it 'should return a user instance if password is wrong' do
      @user = User.create!(
        first_name: 'John',
        last_name: 'Smith',
        email: 'CY@cy.com',
        password: 'something',
        password_confirmation: 'something'
      )

      @user2 = User.authenticate_with_credentials('cy@cy.com', 'something')
      expect(@user2).to eq @user
    end
  
  end


end
