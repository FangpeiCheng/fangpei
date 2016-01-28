class CommentsController < ApplicationController
	def create
		@micropost = Micropost.find(params[:micropost_id])
		@comment = @micropost.comments.create(params[:comment].permit(:content))

		if @comment.save
			redirect_to micropost_path(@micropost)
		else
			render 'new'
		end
	end
end
