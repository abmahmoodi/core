class CreateRwUserTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :rw_user_types do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
