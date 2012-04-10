require 'spec_helper'

describe Link do

  before do
    @link = FactoryGirl.create(:link)
  end

  context "validations" do
    it 'requires link type' do
    link = FactoryGirl.attributes_for(:link, :link_type => nil)
    link_error = Link.create(link)
    link_error.errors.size.should == 1
    end

    it 'requires a project' do
    link = FactoryGirl.attributes_for(:link, :project => nil)
    link_error = Link.create(link)
    link_error.errors.size.should == 1
    end

  end

end
