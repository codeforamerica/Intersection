require 'spec_helper'

describe "links/index.html.haml" do
  before(:each) do
    assign(:links, [
      stub_model(Link,
        :name => "Name",
        :link => "Link",
        :project_id => 1,
        :link_type_id => 1
      ),
      stub_model(Link,
        :name => "Name",
        :link => "Link",
        :project_id => 1,
        :link_type_id => 1
      )
    ])
  end

  it "renders a list of links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
