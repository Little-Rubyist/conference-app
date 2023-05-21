require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /index" do
    before do
      sign_in(user)
    end

    it "returns http success" do
      get "/profiles"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    before do
      sign_in(user)
    end

    it "returns http success" do
      get "/profiles/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /profiles" do
    before do
      sign_in(user)
    end

    context "valid profile" do
      it "should create profile" do
        post "/profiles", params: { profile: { name: "foobar", description: "I'm foobar!" } }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(profiles_path)
        expect(Profile.where(user: user).count).to eq 1
      end
    end
  end
end
