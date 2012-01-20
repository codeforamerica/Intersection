require 'spec_helper'

describe "surveys/index.html.haml" do
  before(:each) do
    assign(:surveys, [
      stub_model(Survey,
        :name => "Name",
        :survey_type => "Survey Type",
        :scale => 1,
        :frequency => 2,
        :start_date => Time.now,
        :end_date => Time.now
      ),
      stub_model(Survey,
        :name => "Name",
        :survey_type => "Survey Type",
        :scale => 1,
        :frequency => 2,
        :start_date => Time.now,
        :end_date => Time.now
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
    assert_select "tr>td", :text => "2 weeks".to_s, :count => 2
  end
end
