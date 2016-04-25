class Comment < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user

  validates :content, presence: true, length: { maximum: 300 }
end
