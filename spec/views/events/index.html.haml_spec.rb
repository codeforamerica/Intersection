require 'spec_helper'

describe "events/index" do
  before(:each) do
    @event = FactoryGirl.create(:event, :name => "Name", :attendance => 1, :url => "Url", :description => "MyText")
    assign(:events, [
      @event, @event
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
