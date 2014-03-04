require 'spec_helper'

describe CalculationsController do

  describe "GET 'index'" do
    it "populates an array of calculations" do
      calculation = create(:calculation)
      get :index
      expect(assigns(:calculation)).to match_array [calculation]
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "assigns the required calculation to @calculation" do
      calculation = create(:calculation)
      get :show, id: calculation
      expect(assigns(:calculation)). to eq calculation
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new calculation to the database"
      it "redirects to the show page"
    end

    context "with invalid attributes" do
      it "does not save the new calculation to the database"
      it "re-renders the new template"
    end

  end
end
