class GoalsController < ApplicationController
	before_action :correct_user,   only: :destroy

	def create
		@dream = Dream.find(params[:dream_id])
		@goal = @dream.goals.create(params[:goal].permit(:content, :name, :deadline))
        @goal.user_id = current_user.id
		if @goal.save
			redirect_to dream_path(@dream)
		else
			render 'new'
		end
	end

	def destroy
       @dream = Dream.find params[:dream_id]
       @goal = @dream.goals.find params[:id]
       @goal.destroy
       flash[:success] = "One goal deleted"
       redirect_to dream_path(@dream)
    end

    private

    def correct_user
        @goal = current_user.goals.find_by(id: params[:id])
        redirect_to dream_path if @goal.nil?
    end

	


end
