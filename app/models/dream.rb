class Dream < ActiveRecord::Base
  belongs_to :user
  has_many :goals, dependent: :destroy #new line
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30}
  validates :content, presence: true, length: { maximum: 200 }
  validates :date, presence: true

      

end
