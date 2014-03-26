# encoding: utf-8
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @titre = @user.nom
  end

  def listecv
    @liste = User.find(:all)
  end

  def liste_non_sportif
    @liste = User.where({faire_sport: '0'} && {aimer_faire_sport: '1'})
  end

  def new
    @user = User.new	
    @titre = "Inscription"
  end

  def show_pdf
    respond_to do |format|
      format.html { render :show_pdf }
      format.pdf { 
        render :pdf => "show_pdf", :layout => 'pdf.html'
      }
    end
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
