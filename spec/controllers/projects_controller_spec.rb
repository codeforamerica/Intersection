require 'spec_helper.rb'

describe ProjectsController do
  before do
    @user = Factory(:user)
    @project = Factory(:project)
  end

  context "any visitor" do
    it "should allow viewing all projects" do
      get :index
      response.should be_success
    end

    it "should allow viewing project" do
      get :show, :id => @project.id
      response.should be_success
    end
   
    it "should not allow edit, update, create, or destroy" do
      get :destroy, :id => @project.id
      response.should be_redirect
      put :update, :id => @project.id, :profile => {:name => 'something'}
      response.should be_redirect
      get :edit, :id => @project.id
      response.should be_redirect
      post :create, Factory.attributes_for(:project)
      response.should be_redirect
    end

  end
  
  context "any nonadmin user" do
    before do
      sign_in(@user)
    end

    it "should allow viewing all projects" do
      get :index
      response.should be_success
    end

    it "should allow viewing project" do
      get :show, :id => @project.id
      response.should be_success
    end
   
    it "should allow editing of a project" do
      put :update, :id => @project.id, :project => {:name => 'something'}
      @project.reload.name.should == 'something'
    end
     
    it "should allow destroy" do
      delete :destroy, :id => @project.id
      Project.count.should == 0
      response.should be_redirect
    end

    it "should allow create" do
      post :create, :project => Factory.attributes_for(:project)
      Project.count.should==2
      response.should be_redirect
    end

  end


end
