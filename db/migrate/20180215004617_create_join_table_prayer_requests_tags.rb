class CreateJoinTablePrayerRequestsTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :prayer_requests, :tags do |t|
      # t.index [:prayer_request_id, :tag_id]
      # t.index [:tag_id, :prayer_request_id]
    end
  end
end
