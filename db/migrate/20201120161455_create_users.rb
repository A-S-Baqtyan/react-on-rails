class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.string :mobile
      t.string :address, null: false 
      t.string :password_digest, null: false
      t.integer :status, null: false, default: 0
      t.integer :role, null: false, default: 0

      t.timestamps
      t.index(%i[status role])
      t.index(:email, unique: true)
      t.index(:mobile, unique: true)
      t.index(:password_digest, unique: true)
    end
  end
end
