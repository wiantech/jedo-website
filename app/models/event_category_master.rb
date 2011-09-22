class EventCategoryMaster < ActiveRecord::Base
  scope :find_category, lambda {
        {
        :conditions => ["parent_id= ?", 0]
        }
    }

    scope :find_subcategory, lambda { |parent_id|
        {
        :conditions => ["parent_id= ?", parent_id]
        }
    }

    scope :find_category_name, lambda { |category_id|
        {
        :select => "event_cat_name",
        :conditions => ["id= ?", category_id],
        :limit => 1
        }
    }
end
