class Tag < ActiveRecord::Base
	has_many :taggings, dependent: :destroy
    has_many :microposts, through: :taggings, dependent: :destroy


    def self.counts
      self.select("name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id").order("count DESC")
    end

end

