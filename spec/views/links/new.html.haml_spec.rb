require 'spec_helper'

describe "links/new.html.haml" do
  before(:each) do
    assign(:link, stub_model(Link,
      :name => "MyString",
      :link => "MyString",
      :project_id => 1,
      :link_type_id => 1
    ).as_new_record)
  end

  it "renders new link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => links_path, :method => "post" do
      assert_select "input#link_name", :name => "link[name]"
      assert_select "input#link_link", :name => "link[link]"
      assert_select "input#link_project_id", :name => "link[project_id]"
      assert_select "input#link_link_type_id", :name => "link[link_type_id]"
    end
  end
end
