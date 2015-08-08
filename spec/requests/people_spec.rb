require 'rails_helper'

RSpec.describe "People", type: :request do
  describe "GET /person/new" do
    it "works" do
      get new_person_path
      expect(response).to have_http_status(200)
    end
  end
end
