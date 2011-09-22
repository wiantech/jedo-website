class CreateEventRecommendations < ActiveRecord::Migration
  def self.up
    create_table :event_recommendations do |t|
      t.references :event
      t.integer :recommender_id
      t.integer :recommendee_id
      t.integer :event_message_status_id
      t.integer :recommendation_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :event_recommendations
  end
end
