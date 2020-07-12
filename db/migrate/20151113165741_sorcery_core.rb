class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :rw_users do |t|
      t.string :email, :null => false
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end

    add_index :rw_users, :email, unique: true
  end
end