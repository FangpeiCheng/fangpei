class CommentsController < ApplicationController
	before_action :correct_user,   only: :destroy
  


	def create
		@micropost = Micropost.find(params[:micropost_id])
		@comment = @micropost.comments.create(params[:comment].permit(:content))
        @comment.user_id = current_user.id
		if @comment.save
			#redirect_to micropost_path(@micropost)
			respond_to do |format|
				format.html {redirect_to micropost_path(@micropost)}
				format.js #render comments/create.js.erb
			end
		else
			render 'new'
		end
	end

	def destroy
       @micropost = Micropost.find params[:micropost_id]
       @comment = @micropost.comments.find params[:id]
       @comment.destroy
       redirect_to micropost_path(@micropost)
    end

    private

    def correct_user
        @comment = current_user.comments.find_by(id: params[:id])
        redirect_to root_url if @comment.nil?
    end

	
end
