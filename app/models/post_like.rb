class PostLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost
  
  #the following is new line to implement postlike
  validates_uniqueness_of :micropost_id, scope: :user_id
  validates_inclusion_of :value, in: [1, -1]
  validate :ensure_not_author
  #ensure that author cannot do like for his or her own post
  def ensure_not_author
    errors.add :user_id, "is the author of the micropost" if micropost.user_id == user_id
  end

end

