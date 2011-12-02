require 'spec_helper'

describe "teams/index.html.haml" do
  before(:each) do
    assign(:teams, [
      stub_model(Team,
        :name => "Name",
        :active => false
      ),
      stub_model(Team,
        :name => "Name",
        :active => false
      )
    ])
  end

  it "renders a list of teams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
