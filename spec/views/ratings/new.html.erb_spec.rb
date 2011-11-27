require 'spec_helper'

describe "ratings/new.html.erb" do
  before(:each) do
    assign(:rating, stub_model(Rating,
      :stars => 1,
      :comments => "MyText",
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new rating form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ratings_path, :method => "post" do
      assert_select "select#rating_stars", :name => "rating[stars]"
      assert_select "textarea#rating_comments", :name => "rating[comments]"
      assert_select "input#rating_name", :name => "rating[name]"
    end
  end
end
