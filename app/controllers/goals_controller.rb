class GoalsController < ApplicationController
	before_action :correct_user,   only: [:edit, :update, :destroy]
    
  # GET /dreams/:dream_id/goals
  def index
    #retrive the dream using params[:dream_id]
    @dream = Dream.find(params[:dream_id])
    #get all the goals of this dream
    @goals = @dream.goals.paginate(page: params[:page])
    if logged_in?
      @goal  = current_user.goals.build  
    end
    
  end

  # GET /dreams/:dream_id/goals/:id
  def show
    #retrieve the dream using params[:dream_id]
    dream = Dream.find(params[:dream_id])
    #retrieve the goal using params[:id]
    @goal = dream.goals.find(params[:id])

    
  end

  # GET /dreams/:dream_id/goals/new
  def new
    #retrieve the dream using params[:dream_id]
    dream = Dream.find(params[:dream_id])
    #build a new one
    @goal = dream.goals.build

    
  end

  # GET /dreams/:dream_id/goals/:id/edit
  def edit
    #retrieve the dream using params[:dream_id]
    dream = Dream.find(params[:dream_id])
    #retrieve the goal using params[:id]
    @goal = dream.goals.find(params[:id])
  end

  # dream /dreams/:dream_id/goals
  def create
    #retrieve the dream using params[:dream_id]
    dream = Dream.find(params[:dream_id])
    #create the goal using params[:goal]
    @goal = dream.goals.create(goal_params)
    @goal.user_id = current_user.id
    
      if @goal.save      
        #for building the correct route to the nested resource goal
        redirect_to dream_goals_path(@goal.dream), :notice => 'Goal was successfully created.'
        
      else
         render  'new'
      end
    
  end

  # PUT /dreams/:dream_id/goals/:id
  def update
    #retrieve the dream using params[:dream_id]
    dream = Dream.find(params[:dream_id])
    #retrieve the goal using params[:id]
    @goal = dream.goals.find(params[:id])

    
      if @goal.update_attributes(goal_params)
        #the number 1 argument of redirect_to is an array, for building the correct route to the nested resource goal
        redirect_to(dream_goals_url, :notice => 'Goal was successfully updated.') 
        
      else
        render  'edit'
      end
  
  end

  # DELETE /dreams/:dream_id/goals/1
	def destroy
       dream = Dream.find params[:dream_id]
       @goal = dream.goals.find params[:id]
       @goal.destroy
       
       redirect_to(dream_goals_url) 
      
  end

    private

    def correct_user
        @goal = current_user.goals.find_by(id: params[:id])
        redirect_to dream_path if @goal.nil?
    end

    def goal_params
        params.require(:goal).permit(:name, :content, :deadline)
    end

  


end
