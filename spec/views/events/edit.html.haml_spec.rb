require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :team_id => 1,
      :name => "MyString",
      :attendance => 1,
      :url => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path(@event), :method => "post" do
      assert_select "select#event_team_id", :name => "event[team_id]"
      assert_select "input#event_name", :name => "event[name]"
      assert_select "input#event_attendance", :name => "event[attendance]"
      assert_select "input#event_url", :name => "event[url]"
      assert_select "textarea#event_description", :name => "event[description]"
    end
  end
end
