class Dream < ActiveRecord::Base
  belongs_to :user
  has_many :goals, dependent: :destroy #new line
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30}
  validates :content, presence: true, length: { maximum: 200 }
  validates :date, presence: true, :if => :date_correct?
 
  #returns true only if dream's date exceed today's date, if not, there will be an error.
  def date_correct?
     if DateTime.parse(self.date) < Date.today
      errors.add(:date, "can't be less than today's date ")
    end  
  end
  

      

end
