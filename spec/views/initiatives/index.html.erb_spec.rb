require 'rails_helper'

RSpec.describe "initiatives/index", type: :view do
  before(:each) do
    assign(:initiatives, [
      Initiative.create!(
        :title => "Title",
        :description => "MyText",
        :link => "Link"
      ),
      Initiative.create!(
        :title => "Title",
        :description => "MyText",
        :link => "Link"
      )
    ])
  end

  it "renders a list of initiatives" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
  end
end
