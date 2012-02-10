require 'spec_helper'

describe "surveys/new" do
  before(:each) do
    assign(:survey, stub_model(Survey,
      :name => "MyString",
      :survey_type => "MyString",
      :scale => 1,
      :frequency => "MyString"
    ).as_new_record)
  end

  it "renders new survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => surveys_path, :method => "post" do
      assert_select "input#survey_name", :name => "survey[name]"
      assert_select "select#survey_survey_type", :name => "survey[survey_type]"
      assert_select "input#survey_scale", :name => "survey[scale]"
      assert_select "select#survey_frequency", :name => "survey[frequency]"
    end
  end
end
