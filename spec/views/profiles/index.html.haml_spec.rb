require 'spec_helper'

describe "profiles/index.html.haml" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
        :user_id => 1,
        :name => "Name",
        :bio => "MyText"
      ),
      stub_model(Profile,
        :user_id => 1,
        :name => "Name",
        :bio => "MyText"
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
