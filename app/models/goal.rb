class Goal < ActiveRecord::Base
  belongs_to :user
  belongs_to :dream
  validates :user_id, presence: true
  validates :dream_id, presence: true
  validates :name, presence: true, length: { maximum: 30}
  validates :content, presence: true, length: { maximum: 200 }
  validates :deadline, presence: true, :if => :deadline_correct?
 

  def deadline_correct?
    if (DateTime.parse(self.deadline) > DateTime.parse(self.dream.date) )|| 
    (DateTime.parse(self.deadline)< Date.today)
      errors.add(:deadline, "can't be more than dream's deadline or less than today's date")
    end  
  end
  # Goal.where("deadline < #{(params[:dram].permit(:date))}")


end
