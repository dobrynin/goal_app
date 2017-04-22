require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the new users page" do
      get :new

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index" do
    it "renders the users index page" do
      get :index

      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    let!(:dave) { User.create!(email: "dave@gmail.com", password: "password") }
    context "with valid user_id" do
      it "renders a user's show page" do
        get :show, params: { id: dave.id }

        expect(response).to render_template(:show)
        expect(response).to have_http_status(200)
      end
    end

    context "with an invalid user_id" do
      it "renders the users index page" do
        get :show, params: { id: dave.id + 1 }

        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe "Get #edit" do
    let!(:dave) { User.create!(email: "dave@gmail.com", password: "password") }
    context "with valid user_id" do
      it "renders a user's edit page" do

        get :edit, params: { id: dave.id  }

        expect(response).to render_template(:edit)
        expect(response).to have_http_status(200)
      end
    end

    context "with an invalid user_id" do
      it "renders the users index page" do
        get :edit, params: { id: dave.id + 1  }

        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "redirects to the home page" do
        post :create, params: { user: { email: "dave@gmail.com", password: "password" } }
        expect(response).to redirect_to(users_url)
      end
    end

    context "with invalid params" do
      it "validates the presence of email and password" do
        post :create, params: { user: { email: "dave@gmail.com" } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let!(:dave) { User.create!(email: "dave@gmail.com", password: "password") }

    context "with valid params" do
      it "redirects to the user's show page" do
        patch :update, params: { id: dave.id, user: { email: "dd@gmail.com", password: "password" } }
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "validates the presence of email and password" do
        patch :update, params: { id: dave.id, user: { email: nil, password: "short" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:dave) { User.create!(email: "dave@gmail.com", password: "password") }
    it "redirects to the home page" do
      delete :destroy, params: { id: dave.id }
      expect(response).to redirect_to(users_url)
    end
  end
end
