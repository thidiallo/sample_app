# encoding: utf-8
require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :nom => "Thierno Aguibou DIALLO",
      :date => "15/11/1986",
      :poids_actu => 60,
      :poids_ideal => 55,
      :taille => 1.57,
      :email => "aguibou_diallo@yahoo.fr",
      :faire_sport => "0",
      :aimer_faire_sport => "1",
      :password => "ce1mdpp1",
      :password_confirmation => "ce1mdpp1"
    }
  end

  it "devrait créer une nouvelle instance avec des attributs valides" do
     User.create!(@attr)
  end
       
       # Test champ nom.
  it "exige un nom" do
     bad_guy = User.new(@attr.merge(:nom => ""))
     bad_guy.should_not be_valid
  end
  
  it "devrait rejeter les noms trop longs" do
     long_nom = "a" * 51
     long_nom_user = User.new(@attr.merge(:nom => long_nom))
     long_nom_user.should_not be_valid
  end
  
       # Test champ email.
  it "devrait accepter une adresse email valide" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "devrait rejeter une adresse email invalide" do
     adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
     adresses.each do |address|
     invalid_email_user = User.new(@attr.merge(:email => address))
     invalid_email_user.should_not be_valid
    end
  end

  it "devrait rejeter un email double" do
     # Place un utilisateur avec un email donné dans la BD.
     User.create!(@attr)
     user_with_duplicate_email = User.new(@attr)
     user_with_duplicate_email.should_not be_valid
  end

  it "devrait rejeter une adresse email invalide jusqu'à la casse" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

	  # Test champ Date
  it "devrait rejeter une date vide" do
     mauvaiseDate= User.new(@attr.merge(:date => ""))
     mauvaiseDate.should_not be_valid
  end  

     # Test champ poids actuel
   it "devrait rejeter un poids vide" do
      poidsvide = User.new(@attr.merge(:poids_actu => ""))
      poidsvide.should_not be_valid
   end
   
   it "devrait rejeter un poids avec virgule" do
      poids = User.new(@attr.merge(:poids_actu => "55,3"))
      poids.should_not be_valid
   end
   
   # Test champ poids ideal
   it "devrait rejeter un poids vide" do
      poidsvide = User.new(@attr.merge(:poids_ideal => ""))
      poidsvide.should_not be_valid
   end
   
   it "devrait rejeter un poids avec virgule" do
      poids = User.new(@attr.merge(:poids_ideal => "55,3"))
      poids.should_not be_valid
   end
   
   it "devrait rejeter un poids ideal superieur au poids actuel" do
      poids = User.new(@attr.merge({:poids_actu => 55, :poids_ideal => 57 }))
      poids.should_not be_valid
   end
   
   # Test champ taille
   it "devrait rejeter une taille vide" do
      taille = User.new(@attr.merge(:taille => ""))
      taille.should_not be_valid
   end
   
   it "devrait rejeter une taille avec virgule" do
      taille = User.new(@attr.merge(:taille => "1,3"))
      taille.should_not be_valid
   end
   
   it "devrait rejeter une taille supperieur à 3 m" do
      taille = User.new(@attr.merge(:taille => 3.5))
      taille.should_not be_valid
   end
     
     # Test champs password et confirmation
  describe "password validations" do

    it "devrait exiger un mot de passe" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "devrait exiger une confirmation du mot de passe qui correspond" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "devrait rejeter les mots de passe (trop) courts" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "devrait rejeter les (trop) longs mots de passe" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "devrait avoir un attribut  mot de passe crypté" do
      @user.should respond_to(:encrypted_password)
    end

    describe "Méthode has_password?" do

      it "doit retourner true si les mots de passe coïncident" do
        @user.has_password?(@attr[:password]).should be_true
      end    

      it "doit retourner false si les mots de passe divergent" do
        @user.has_password?("invalide").should be_false
      end 
    end

    describe "authenticate method" do

      it "devrait retourner nul en cas d'inéquation entre email/mot de passe" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "devrait retourner nil quand un email ne correspond à aucun utilisateur" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "devrait retourner l'utilisateur si email/mot de passe correspondent" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end

end


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  nom                :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

