class RelationshipsController < ApplicationController
  before_action :logged_in_user
  

  def create
  	user = User.find(params[:followed_id])
    current_user.follow(user)    #if follow, do the following js
    respond_to do |format|
      format.html { redirect_to @user }
      format.js    #render create.js.erb
      
    end  
  end

  def destroy
  	user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)   #if unfollow, do the following js
    respond_to do |format|
      format.html { redirect_to @user }
      format.js    #render destory.js.erb
    end
  end
end
