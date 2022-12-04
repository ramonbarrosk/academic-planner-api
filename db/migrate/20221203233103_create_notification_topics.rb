class CreateNotificationTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_topics do |t|
      t.references :notification, index: true, foreign_key: true
      t.references :topic, index: true, foreign_key: true

      t.timestamps
    end
  end
end
