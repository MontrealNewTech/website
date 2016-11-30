require 'rails_helper'

RSpec.describe "initiatives/new", type: :view do
  before(:each) do
    assign(:initiative, Initiative.new(
      :title => "MyString",
      :description => "MyText",
      :link => "MyString"
    ))
  end

  it "renders new initiative form" do
    render

    assert_select "form[action=?][method=?]", initiatives_path, "post" do

      assert_select "input#initiative_title[name=?]", "initiative[title]"

      assert_select "textarea#initiative_description[name=?]", "initiative[description]"

      assert_select "input#initiative_link[name=?]", "initiative[link]"
    end
  end
end
