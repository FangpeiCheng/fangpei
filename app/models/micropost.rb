class Micropost < ActiveRecord::Base
      belongs_to :user    # Association with User

      validates :user_id, presence: true
      validates :content, presence: true, length: { maximum: 140 }
      validates :title, presence: true, length: { maximum: 40 }
      default_scope -> { order(created_at: :desc) }
    end