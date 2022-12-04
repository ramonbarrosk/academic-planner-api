class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.datetime :date
      t.boolean :status, default: false
      t.references :user, index: true, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
