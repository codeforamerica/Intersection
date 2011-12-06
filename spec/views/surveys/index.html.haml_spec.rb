require 'spec_helper'

describe "surveys/index.html.haml" do
  before(:each) do
    assign(:surveys, [
      stub_model(Survey,
        :name => "Name",
        :survey_type => "Survey Type",
        :scale => 1,
        :frequency => "Frequency"
      ),
      stub_model(Survey,
        :name => "Name",
        :survey_type => "Survey Type",
        :scale => 1,
        :frequency => "Frequency"
      )
    ])
  end

  it "renders a list of surveys" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Survey Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Frequency".to_s, :count => 2
  end
end
