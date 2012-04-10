require 'spec_helper'

describe Profile do

  context 'validates' do
    it "should create a profile upon user creation" do
      Profile.count.should==0
      FactoryGirl.create(:user)
      Profile.count.should==1
    end

  end

  context 'methods' do
  end
end
