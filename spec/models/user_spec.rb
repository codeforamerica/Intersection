require 'spec_helper'

describe 'User' do

  context 'has accessible attribute' do
    before do
      @user = Factory(:user)
    end
    it("email") { @user.respond_to?(:email).should be_true }
    it("admin") { @user.respond_to?(:admin).should be_true }
    it("remember_me") { @user.respond_to?(:remember_me).should be_true }
  end
  context 'has association with' do
    before do
      @user = Factory(:user)
    end
  end
  context 'validates' do
  end
  context 'methods' do
  end
end
