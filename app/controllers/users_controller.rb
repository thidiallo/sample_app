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
    @liste = User.find(:faire_sport == "0", :aimer_faire_sport == "1")
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
