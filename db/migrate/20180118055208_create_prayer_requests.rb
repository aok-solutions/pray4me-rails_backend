class CreatePrayerRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :prayer_requests do |t|
      t.references :user, foreign_key: true
      t.string :subject
      t.text :description

      t.timestamps
    end
  end
end
