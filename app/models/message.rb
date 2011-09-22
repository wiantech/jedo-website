class Message < ActiveRecord::Base

before_create :msg_created 
  def msg_created 
    self.foo = Time.now
  end

end
