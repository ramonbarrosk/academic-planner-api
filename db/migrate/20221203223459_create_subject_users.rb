class CreateSubjectUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :subject_users do |t|
      t.references :subject, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
