require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

  end

  describe "POST #create" do
    context "with valid attributes" do
      
      it "create new session" do
        post :create, :params => {:explicit_token => "{'token_type':'bearer','created_at':1499933799,'access_token':'888189ef9cdea38cca6d675d9a361747329fd88955a09a9e18fcf35fdad101d5','refresh_token':null,'expires_at':null}"}
        expect(Session.count).to eq(1)
      end

    end

    context "with invalid attributes" do
 
      it "redirects to session#new" do
        post :create, :params => {:explicit_token => nil}
        expect(response).to redirect_to(:action => :new)
      end
 
    end
  end

  describe "GET #show with current session" do
    
    let(:session_instance) { FactoryGirl.create(:session) }

    it "renders the show template" do
      get :show, :params => {:id => session_instance.id}, :session => {:current_session_id => session_instance.id}
      expect(response).to render_template("show")
    end

  end

  describe "GET #show without current session" do
    
    let(:session_instance) { FactoryGirl.create(:session) }

    it "redirects to sessions#new" do
      get :show, :params => {:id => session_instance.id}
      expect(response).to redirect_to(:action => :new)
    end

  end

end