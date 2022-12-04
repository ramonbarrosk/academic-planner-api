class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :study_hours
      t.boolean :status, default: false
      t.references :user, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
