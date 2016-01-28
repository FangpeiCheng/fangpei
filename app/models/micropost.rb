class Micropost < ActiveRecord::Base
      belongs_to :user    # Association with User
      
      has_many :comments, dependent: :destroy

      mount_uploader :picture, PictureUploader

      has_many :taggings, dependent: :destroy
      has_many :tags, through: :taggings, dependent: :destroy
      validates :user_id, presence: true
      validates :content, presence: true, length: { maximum: 140 }
      validates :title, presence: true, length: { maximum: 40 }
      default_scope -> { order(created_at: :desc) }

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end
  
  def all_tags=(names)
  self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
  end
end

def all_tags
  self.tags.map(&:name).join(", ")
end

def self.tagged_with(name)
  Tag.find_by_name!(name).microposts
end




end

   