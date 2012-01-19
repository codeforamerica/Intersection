require 'spec_helper'

describe "events/show.html.haml" do
  before(:each) do
    @event = Factory(:event, :name => "Name", :attendance => 1, :url => "Url", :description => "MyText")
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
