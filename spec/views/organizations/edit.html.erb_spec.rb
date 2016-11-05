require 'rails_helper'

RSpec.describe "organizations/edit", type: :view do
  before(:each) do
    @organization = assign(:organization, Organization.create!(
      :name => "MyString",
      :description => "MyText",
      :logo => "MyString"
    ))
  end

  it "renders the edit organization form" do
    render

    assert_select "form[action=?][method=?]", organization_path(@organization), "post" do

      assert_select "input#organization_name[name=?]", "organization[name]"

      assert_select "textarea#organization_description[name=?]", "organization[description]"

      assert_select "input#organization_logo[name=?]", "organization[logo]"
    end
  end
end
