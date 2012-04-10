require 'spec_helper'

describe 'User' do
  before do
    @user = FactoryGirl.create(:user)
  end

  context 'has accessible attribute' do
    it("email") { @user.respond_to?(:email).should be_true }
    it("admin") { @user.respond_to?(:admin).should be_true }
    it("remember_me") { @user.respond_to?(:remember_me).should be_true }
  end
  context 'has association with' do
  end
  context 'validates' do
    it "should have a profile:" do
      @user.profile.should_not nil
    end
  end
  context 'methods' do
  end
end
