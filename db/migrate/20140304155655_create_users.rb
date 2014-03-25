class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :nom
      t.column :date, :date
      t.string :poids_actu
      t.string :poids_ideal
      t.string :taille
      t.string :email
      t.string :faire_sport
      t.string :aimer_faire_sport
      t.binary :cv

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
