require 'spec_helper'

describe "stories/edit.html.haml" do
  before(:each) do
    @story = assign(:story, stub_model(Story,
      :user_id => 1,
      :project_id => 1,
      :team_id => 1,
      :story => "MyText"
    ))
  end

  it "renders the edit story form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stories_path(@story), :method => "post" do
      assert_select "input#story_user_id", :name => "story[user_id]"
      assert_select "input#story_project_id", :name => "story[project_id]"
      assert_select "input#story_team_id", :name => "story[team_id]"
      assert_select "textarea#story_story", :name => "story[story]"
    end
  end
end
