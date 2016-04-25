class Micropost < ActiveRecord::Base
      belongs_to :user    # Association with User
      belongs_to :dream   # Association with Dream, 
      
      has_many :comments, dependent: :destroy
      
      has_many :post_likes

      mount_uploader :picture, PictureUploader

      has_many :taggings, dependent: :destroy
      has_many :tags, through: :taggings, dependent: :destroy
      validates :user_id, presence: true
      validates :content, presence: true, length: { maximum: 400 }
      validates :title, presence: true, length: { maximum: 50 }
      validate  :picture_size

      default_scope -> { order(created_at: :desc) }


   #order by the number of post_likes, actually not used, set it aside.
  def self.by_likes
    select('microposts.*, coalesce(value, 0) as likes').
    joins('left join post_likes on micropost_id=microposts.id').
    order('likes desc')
  end

  #return the sum of post_like
  def likes
    read_attribute(:likes) || post_likes.sum(:value)
  end



  def self.search(query)
    #return the posts whose title or content equals the query
    where("title like ? or content like ?", "%#{query}%","%#{query}%") 
  end
  
  def all_tags=(names)

    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags

    self.tags.map(&:name).join(", ")
  end

  def self.find_tag(name)
    
    Tag.find_by_name!(name).microposts
  end

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 2.megabytes
        errors.add(:picture, "The size should be less than 2MB")
      end
    end


end

   