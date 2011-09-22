class CreateRecommendationTypes < ActiveRecord::Migration
  def self.up
    create_table :recommendation_types do |t|
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :recommendation_types
  end
end
