require 'spec_helper'

describe FeedstocksController do

	describe 'GET #index' do
		it "populates an array of feedstocks" do
			feedstock = create(:feedstock)
			get :index
			expect(assigns(:feedstocks)).to match_array [feedstock]
		end

		it "renders the :index view" do
			get :index
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
		it "assigns the required feedstock to @feedstock" do
			feedstock = create(:feedstock)
			get :show, id: feedstock
			expect(assigns(:feedstock)). to eq feedstock
		end 

		it "renders the :show template" do
			feedstock = create(:feedstock)
			get :show, id: feedstock
			expect(response). to render_template :show
		end
	end

	describe 'GET #new' do
		it "assigns a new Feedstock to @feedstock" do
			get :new
			expect(assigns(:feedstock)).to be_a_new(Feedstock)
		end

		it "renders the :new template" do
			get :new
			expect(response).to render_template :new
		end
	end

	describe "POST #create" do
		context "with valid attributes" do

			it "saves the new feedstock in the database" do
				expect{
					post :create, feedstock: attributes_for(:feedstock)
				}.to change(Feedstock, :count).by(1)
			end

			it "redirects to the show page" do
				post :create, feedstock: attributes_for(:feedstock)
				expect(response). to render_template @feedstock
			end
		end

		context "with invalid attributes" do
			it "does not save the new feedstock in the database" do
				expect{
					post :create,
					feedstock: attributes_for(:invalid_feedstock)
				}.to_not change(Feedstock, :count)
			end

			it "re_renders the :new template" do
				post :create,
					feedstock: attributes_for(:invalid_feedstock)
				expect(response). to render_template :new
			end
		end

	end
end