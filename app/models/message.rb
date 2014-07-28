class Message < ActiveRecord::Base
  belongs_to :user
  default_scope {order('created_at DESC')} #Changes the Default Sort Order to (Created At.)
  before_save :message_redirect

  def message_redirect
    if self.message_type == "inquiry"
      self.wallet_price = self.proposed_price * 1.15 #calculates our percentage
      self.subject = "Congrats, #{User.find(self.sender_id).first_name} wants to complete your task for $#{self.wallet_price}"
      #if self.body.present?
      #self.body = "Message from Runner(#{User.find(self.sender_id).first_name}): #{self.body}. Price:$#{self.wallet_price}.You can accept task and give Runner instructions and your contact info or decline based on reviews / rating. Task will decline in 24 hours."
      #else
      self.body = "#{User.find(self.sender_id).first_name} wants to complete your task for $#{self.wallet_price}. You can accept task and give Runner instructions and your contact info or decline based on reviews / rating. Task will decline in 24 hours."
      #end
    end
    if self.message_type == "decline"
      if self.body.empty?
        self.body = "This is not the end of the world, etc. build up ratings, blah blah"
      end
    end
  end
end
