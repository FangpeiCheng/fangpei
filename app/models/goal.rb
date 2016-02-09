class Goal < ActiveRecord::Base
  belongs_to :user
  belongs_to :dream
  validates :user_id, presence: true
  validates :dream_id, presence: true
  validates :name, presence: true, length: { maximum: 30}
  validates :content, presence: true, length: { maximum: 200 }
  validates :deadline, presence: true

end
