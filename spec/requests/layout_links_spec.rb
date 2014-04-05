# encoding: utf-8
require 'spec_helper'

describe "LayoutLinks" do

   # Test du lien listeUser
  it "devrait trouver une page Liste utilisateur à '/listeUser'" do
    get '/listeUser'
    response.should have_selector('title', :content => "Liste des utilisateurs")
  end
  
  # Test du lien listeNonSportif
  it "devrait trouver une page Liste utilisateur à '/listeNonSportif'" do
    get '/listeNonSportif'
    response.should have_selector('title', :content => "Liste des utilisateurs non sportifs")
  end
  
  # Test du lien listePdf
  it "devrait trouver une page Liste utilisateur à '/listePdf'" do
    get '/listePdf'
    response.should have_selector('title', :content => "Liste des utilisateurs en pdf")
  end

  it "devrait trouver une page Accueil à '/'" do
    get '/'
    response.should have_selector('title', :content => "Accueil")
  end

  it "devrait trouver une page Contact at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an À Propos page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "À Propos")
  end

  it "devrait trouver une page Iade à '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Aide")
  end

  it "devrait avoir une page d'inscription à '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Inscription")
  end

  it "devrait avoir le bon lien sur le layout" do
    visit root_path
    click_link "À Propos"
    response.should have_selector('title', :content => "À Propos")
    click_link "Aide"
    response.should # fill in
    click_link "Contact"
    response.should # fill in
    click_link "Accueil"
    response.should # fill in
    click_link "S'inscrire !"
    response.should # fill in
  end

end
