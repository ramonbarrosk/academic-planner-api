class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :course
      t.integer :period
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
