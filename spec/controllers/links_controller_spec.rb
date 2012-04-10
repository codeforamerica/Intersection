require 'spec_helper.rb'

describe LinksController do

  before do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    @link = FactoryGirl.create(:link, :project => @project)
    @link_type = @link.link_type
  end

  context "any visitor" do
    it "should allow viewing all Links" do
      get :index
      response.should be_success
    end

    it "should allow viewing Link" do
      get :show, :id => @link.id
      response.should be_success
    end

    it "should not allow edit, update, create, or destroy" do
      get :destroy, :id => @link.id
      response.should be_redirect
      put :update, :id => @link.id, :profile => {:name => 'something'}
      response.should be_redirect
      get :edit, :id => @link.id
      response.should be_redirect
      post :create, FactoryGirl.attributes_for(:link)
      response.should be_redirect
    end

  end

  context "any nonadmin user" do
    login_user

    before do
      sign_in(@user)
    end

    it "should allow viewing all Links" do
      get :index
      response.should be_success
    end

    it "should allow viewing Link" do
      get :show, :id => @link.id
      response.should be_success
    end

    it "should allow editing of a Link" do
      put :update, :id => @link.id, :link => {:name => 'something'}
      @link.reload.name.should == 'something'
    end

    it "should allow destroy" do
      delete :destroy, :id => @link.id
      Link.count.should == 0
      response.should be_redirect
    end

    it "should allow create" do
      post :create, :link => FactoryGirl.attributes_for(:link, :project_id => @project.id, :link_type_id => @link_type.id)
      Link.count.should==2
      response.should be_redirect
    end

  end


end
