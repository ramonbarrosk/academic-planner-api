class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.datetime :date
      t.boolean :status
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
