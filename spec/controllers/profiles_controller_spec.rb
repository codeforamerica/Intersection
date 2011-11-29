require 'spec_helper.rb'

describe ProfilesController do
  before do
    @user = Factory(:user)
    @admin = Factory(:admin_user)
  end

  context "any visitor" do
    it "should allow viewing all profiles" do
      get :index
      response.should be_success
    end

    it "should allow viewing profile" do
      get :show, :id => @user.profile.id
      response.should be_success
    end
   
    it "should not allow edit, update, create, or destroy" do
      get :destroy, :id => @user.profile.id
      response.should be_redirect
      put :update, :id => @user.profile.id, :profile => {:name => 'something'}
      response.should be_redirect
      get :edit, :id => @user.profile.id
      response.should be_redirect
      post :create, Factory.attributes_for(:profile)
      response.should be_redirect
    end

  end
  
  context "any user" do
    before do
      sign_in(@user)
    end

    it "should allow viewing all profiles" do
      get :index
      response.should be_success
    end

    it "should allow viewing profile" do
      get :show, :id => @user.profile.id
      response.should be_success
    end
   
    it "should allow editing of only their profile" do
      put :update, :id => @user.profile.id, :profile => {:name => 'something'}
      @user.reload.profile.name.should == 'something'
      put :update, :id => @admin.profile.id, :profile => {:name => 'something'}
      response.should be_false
    end
     
    it "should not allow new, create, or destroy" do
      delete :destroy, :id => @user.profile.id
      response.should be_false
      post :create, Factory.attributes_for(:profile)
      response.should be_false
    end

  end

end
