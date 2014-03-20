require 'spec_helper'

describe ProjectsController do

  describe "GET 'index'" do
    it "populates an array of projects" do
      project = create(:project)
      get :index
      expect(assigns(:projects)).to match_array [project]
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET 'new'" do
    it "assigns a new project to @project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    it "assigns the requested project to @project" do
      project = create(:project)
      get :show, id: project
      expect(assigns(:project)). to eq project
    end

    it "renders the show template" do
      project = create(:project)
      get :show, id: project
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do

      it "creates a new project" do
        project = create(:project)
        expect{
          post :create, project: attributes_for(:project)
        }.to change(project, :count).by(1)
      end

      it "redirects to the new project" do
        post :create, project: attributes_for(:project)
        expect(response). to render_template :show
      end
    end
  end

end
