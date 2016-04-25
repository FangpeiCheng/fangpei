class User < ActiveRecord::Base
  has_many :dreams, dependent: :destroy #new line
  has_many :goals, dependent: :destroy #new line
  has_many :microposts, dependent: :destroy   #  CHANGED
  has_many :comments, dependent: :destroy

  has_many :post_likes #like function

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  default_scope { order('created_at DESC') }
	attr_accessor :remember_token
	before_save { self.email = email.downcase }

	validates :name, presence: true, length: { in: 9..30 }, uniqueness: { case_sensitive: false }
     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
     validates :email, presence: true, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
     validates :password, presence: true, length: { minimum: 6 }, allow_nil: true#new line
     validates :password_confirmation, presence: true
     has_secure_password

     # where(:name query) -> This would return an exact match of the query
     def self.search(query)
      where("name like ?", "%#{query}%") 
     end

     #like function
     def total_likes
       PostLike.joins(:micropost).where(microposts: {user_id: self.id}).sum('value')
     end

     def can_like_for?(micropost)
       post_likes.build(value: 1, micropost: micropost).valid?
     end

     

     # returns the hash digest of a string.
      def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end

      # returns a random token.
      def User.new_token
        SecureRandom.urlsafe_base64
      end

      # remembers a user in the database for use in persistent sessions.
      def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
      end
      # Returns true if the given token matches the digest.
      def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
      end
      # Forgets a user. may be not used
      def forget
        update_attribute(:remember_digest, nil)
      end
      
      # Returns true if a password reset has expired.
      def password_reset_expired?
        reset_sent_at < 2.hours.ago
      end

      #returns user's following posts
      def feed_post
        #query the database to find the following posts using the follower_id
        following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
        Micropost.where("user_id IN (#{following_ids})", user_id: id)

      end

      #returns user's own dreams
      def feed
        #query the database to find dreams using the user's id 
        Dream.where("user_id = ?", id)
      end

      # define a method to follow a user.
      def follow(other_user)
        active_relationships.create(followed_id: other_user.id)
      end

      # define a method to unfollow a user.
      def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
      end

      # judge whether the current user follow others', returns true if the user is following others.
      def following?(other_user)
        following.include?(other_user)
      end
end
