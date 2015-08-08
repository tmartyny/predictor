require 'rails_helper'

RSpec.describe "people/new", type: :view do
  before(:each) do
    assign(:person, Person.new(
      :weight => 1,
      :height => 1,
      :gender => "MyString"
    ))
  end

  it "renders new person form" do
    render

    assert_select "form[action=?][method=?]", people_path, "post" do

      assert_select "input#person_weight[name=?]", "person[weight]"

      assert_select "input#person_height[name=?]", "person[height]"

    end
  end
end
