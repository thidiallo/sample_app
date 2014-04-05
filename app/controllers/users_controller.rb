# encoding: utf-8
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @titre = @user.nom
  end

  def listePdf
   @titre = "Liste des utilisateurs en pdf"
   @liste = User.find(:all)
    
    pdf_content = PdfDocument.new.to_pdf

    respond_to do |format|
      format.pdf do
        send_data pdf_content, filename: "liste.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def listeUserCV
    @titre = "Liste des utilisateurs"
    @liste = User.find(:all)
  end

  def listeNonSportif
    @titre = "Liste des utilisateurs non sportifs"
    @liste = User.where({faire_sport: '0'} && {aimer_faire_sport: '1'})
  end

  def new
    @user = User.new	
    @titre = "Inscription"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue dans l'Application Exemple !"
      redirect_to @user
    else
      @titre = "Sign up"
      render 'new'
    end
  end
end
