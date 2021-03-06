class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :nom
      t.column :date, :date
      t.float  :poids_actu
      t.float  :poids_ideal
      t.float  :taille
      t.string :email
      t.string :faire_sport
      t.string :aimer_faire_sport

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
