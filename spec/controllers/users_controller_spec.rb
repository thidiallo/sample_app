# encoding: utf-8
require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "devrait réussir" do
      get 'new'
      response.should be_success
    end

    it "devrait avoir le titre adéquat" do
      get 'new'
      response.should have_selector("title", :content => "Inscription")
    end
  end

     # Test sur l'action show
  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "devrait réussir" do
      get :show, :id => @user
      response.should be_success
    end

    it "devrait trouver le bon utilisateur" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "devrait avoir le bon titre" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.nom)
    end

    it "devrait inclure le nom de l'utilisateur" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.nom)
    end

    it "devrait avoir une image de profil" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end

  end
  
  # Test sur l'action listeUserCV
  describe "GET 'listeUserCV'" do
    it "devrait avoir 'Liste des utilisateurs et leurs CV' en haut de la page" do
      get :listeUserCV
      response.should have_selector("div>h1", :content => "Liste des utilisateurs et leurs CV")
    end

  end
  
  # Test sur l'action listeNonSportif
  describe "GET 'listeNonSportif'" do
    it "devrait avoir 'Liste des utilisateurs non sportifs désirant faire du sport' en haut de la page" do
      get :listeNonSportif
      response.should have_selector("h1", :content => "Liste des utilisateurs non sportifs désirant faire du sport")
    end

  end
  
  # Test sur l'action listePdf
  describe "GET 'listePdf'" do
    it "devrait avoir 'Nom' comme titre"  do
      get :listePdf
      response.should have_selector("table>tr>td>strong", :content => "Nom")
    end

  end

      # Test sur l'action create
  describe "POST 'create'" do

    describe "échec" do

      before(:each) do
        @attr = { :nom => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "ne devrait pas créer d'utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "devrait avoir le bon titre" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Inscription")
      end

      it "devrait rendre la page 'new'" do
        post :create, :user => @attr
        response.should render_template('new')
      end
   end

   describe "succès" do

      before(:each) do
        @attr = { :nom => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "devrait créer un utilisateur" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "devrait rediriger vers la page d'affichage de l'utilisateur" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end    

      it "devrait avoir un message de bienvenue" do
        post :create, :user => @attr
        flash[:success].should =~ /Bienvenue dans l'Application Exemple/i
      end
   end

 end
end

