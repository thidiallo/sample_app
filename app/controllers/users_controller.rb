# encoding: utf-8
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @titre = "Inscription"
  end
end
