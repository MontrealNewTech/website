require 'rails_helper'

RSpec.describe "initiatives/show", type: :view do
  before(:each) do
    @initiative = assign(:initiative, Initiative.create!(
      :title => "Title",
      :description => "MyText",
      :link => "Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Link/)
  end
end
