class Interest < ActiveRecord::Base
  belongs_to :user
 # acts_as_list :scope => :user

  scope :find_user_interest, lambda { |user_id|
        {
        :conditions => ["user_id= ?", user_id],
        :order => "position asc"
        }
      }

  scope :find_same_record, lambda { |category_id, subcategory_id, rank, user_id|
        {
        :conditions => ["category_id = ? AND subcategory_id = ? AND rank =? AND user_id = ?",  category_id, subcategory_id, rank, user_id]
        }
      }

  scope :find_same_pair, lambda { |category_id, subcategory_id, user_id|
        {
        :conditions => ["category_id = ? AND subcategory_id = ? AND user_id = ?",  category_id, subcategory_id, user_id]
        }
      }

  scope :find_same_rank, lambda { |rank, user_id|
        {
        :conditions => ["rank = ? AND user_id = ?",  rank, user_id]
        }
      }

  scope :find_single_interest, lambda { |interest_id|
        {
        :conditions => ["id= ?", interest_id],
        :limit => 1
        }
      }

  scope :find_rank, lambda { |user_id|
        {
        :select => "rank",
        :conditions => ["user_id= ?", user_id]
        }
      }
end
