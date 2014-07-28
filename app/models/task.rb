class Task < ActiveRecord::Base
  belongs_to :user

  has_many :reviews
  has_many :notes


  validates_presence_of :subject, :description, :zipcode
  default_scope {order('updated_at DESC')} #Changes the Default Sort Order to (Created At.)
  acts_as_taggable_on :tags
  before_save :task_type_change
  validates_presence_of :price, :if => :task_bid?

  def task_type_change
    if self.rating_required !=0 || self.no_ratings_required != 0
      self.task_type = "auto"
    else
      self.task_type = "bid"
    end
  end

  def runner_price
    runnerprice = self.price * 0.85
  end

  def task_bid?
    self.task_type == "auto" || self.rating_required != 0 || self.no_ratings_required!= 0
  end

  def match_task_to_runner(message)
    self.price = message.proposed_price
    self.status = "pending"
    self.runner_id = message.sender_id
    self.save!
  end

  def viewcalc # calculates task views
    if self.views.nil?
      self.views = 1
    else
      self.views +=1
    end
  end

  def average_rating(user) #need to fix the rounding error!!
    user.reviews.sum(:score) / user.reviews.count
  end
end
