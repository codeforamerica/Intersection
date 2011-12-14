require 'spec_helper'

describe "events/new.html.haml" do
  before(:each) do
    assign(:event, stub_model(Event,
      :team_id => 1,
      :name => "MyString",
      :attendance => 1,
      :url => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_team_id", :name => "event[team_id]"
      assert_select "input#event_name", :name => "event[name]"
      assert_select "input#event_attendance", :name => "event[attendance]"
      assert_select "input#event_url", :name => "event[url]"
      assert_select "textarea#event_description", :name => "event[description]"
    end
  end
end
