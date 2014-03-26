require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :nom, :date, :poids_actu, :poids_ideal, :taille,
                  :email, :faire_sport, :aimer_faire_sport, :password, :password_confirmation, :attach

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  taille_regex = /\A[123](\.\d{1,2})?\z/
  poids_regex = /\A\d{2,3}(\.\d{1,2})?\z/
  
  validates :nom, :presence => true, :length   => { :maximum => 50 }
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }

  validates :taille, :presence => true, :format => { :with => taille_regex }
  validates :poids_actu, :presence => true, :format => { :with => poids_regex }
  validates :poids_ideal, :presence => true, :format => { :with => poids_regex }, :numericality => {:less_than=> :poids_actu}

  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }

  has_attached_file :attach, :presence => true
  #validates_attachment_content_type :attach, :content_type => ["application/pdf"]  
                   
  before_save :encrypt_password

  def faitSport
    if faire_sport == "1"
      return "oui"
    else
      return "non"
    end
  end

  def aimeraiFaireSport
    if aimer_faire_sport == "1"
      return "oui"
    else
      return "non"
    end
  end
 
    # methode de calcul de l'IMC
  def calc_imc
      return (poids_actu / (taille*taille)).to_s()
  end

    #Methode de calcul de l'age
  def age
     if Date.today.year - date.year > 1
        return (Date.today.year - date.year).to_s() +" ans"
     elsif Date.today.year - date.year == 1
        return 1.to_s() +"an"
     elsif Date.today.month - date.month >= 1
        return (Date.today.month - date.month).to-s() + " mois"
     else
        return (Date.today.day - date.day).to_s() + " jours"
     end
  end

  def has_password?(password_soumis)
    encrypted_password == encrypt(password_soumis)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
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

