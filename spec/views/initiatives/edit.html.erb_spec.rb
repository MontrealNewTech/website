require 'rails_helper'

RSpec.describe "initiatives/edit", type: :view do
  before(:each) do
    @initiative = assign(:initiative, Initiative.create!(
      :title => "MyString",
      :description => "MyText",
      :link => "MyString"
    ))
  end

  it "renders the edit initiative form" do
    render

    assert_select "form[action=?][method=?]", initiative_path(@initiative), "post" do

      assert_select "input#initiative_title[name=?]", "initiative[title]"

      assert_select "textarea#initiative_description[name=?]", "initiative[description]"

      assert_select "input#initiative_link[name=?]", "initiative[link]"
    end
  end
end
