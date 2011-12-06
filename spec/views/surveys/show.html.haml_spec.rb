require 'spec_helper'

describe "surveys/show.html.haml" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey,
      :name => "Name",
      :survey_type => "Survey Type",
      :scale => 1,
      :frequency => "Frequency"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Survey Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Frequency/)
  end
end
