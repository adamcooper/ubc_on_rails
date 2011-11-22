require 'spec_helper'

describe "ratings/edit.html.erb" do
  before(:each) do
    @rating = assign(:rating, stub_model(Rating,
      :title => "MyString",
      :stars => 1,
      :comments => "MyText",
      :name => "MyString"
    ))
  end

  it "renders the edit rating form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ratings_path(@rating), :method => "post" do
      assert_select "input#rating_title", :name => "rating[title]"
      assert_select "input#rating_stars", :name => "rating[stars]"
      assert_select "textarea#rating_comments", :name => "rating[comments]"
      assert_select "input#rating_name", :name => "rating[name]"
    end
  end
end
