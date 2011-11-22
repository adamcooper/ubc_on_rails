require 'spec_helper'

describe "ratings/index.html.erb" do
  before(:each) do
    assign(:ratings, [
      stub_model(Rating,
        :title => "Title",
        :stars => 1,
        :comments => "MyText",
        :name => "Name"
      ),
      stub_model(Rating,
        :title => "Title",
        :stars => 1,
        :comments => "MyText",
        :name => "Name"
      )
    ])
  end

  it "renders a list of ratings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
