require 'spec_helper'

describe "stories/index.html.haml" do
  before(:each) do
    assign(:stories, [
      stub_model(Story,
        :user_id => 1,
        :project_id => 1,
        :team_id => 1,
        :story => "MyText"
      ),
      stub_model(Story,
        :user_id => 1,
        :project_id => 1,
        :team_id => 1,
        :story => "MyText"
      )
    ])
  end

  it "renders a list of stories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
