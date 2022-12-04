class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :shift
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
