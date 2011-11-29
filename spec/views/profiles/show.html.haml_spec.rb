require 'spec_helper'

describe "profiles/show.html.haml" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :user_id => 1,
      :name => "Name",
      :bio => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
