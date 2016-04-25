class DreamsController < ApplicationController
	
  before_action :correct_user,   only: [:edit, :update, :destory]
  before_action :find_dream, only: [:show, :edit, :update, :destroy]
  #before_action :correct_user,   only: :destroy
  def index
          if logged_in?
            @dream  = current_user.dreams.build
            @feed_items = current_user.feed
            # remind to create dreams if no dreams, reminde start
            if @feed_items.length==0
              flash[:alert] = "You have no dreams. Create one now to get started."
            end  
            #remind end

          end
        
    end
   
    def new
    	@dream = Dream.new

    end
    def show
      #@dream = Dream.find(params[:id])
      #@goal = @dream.goals.build
    end

    def create
    @dream = current_user.dreams.build(dream_params)
    if @dream.save
      flash[:success] = "Dream created!"
          redirect_to dreams_path #if use '@post', enter post/show screen

          else
          @feed_items = []
          render 'new'
        end
    end

    def edit
    end
  

  
  def update
    if @dream.update(dream_params)
      redirect_to dreams_path
    else
      render 'edit'
    end
  end
  
  def destroy
    #flash[:success] = "User deleted"
    @dream.destroy
    flash[:success] = "One dream deleted"
    redirect_to @dream
  end



  private 

  def find_dream
    @dream = Dream.find(params[:id])
  end

  def dream_params
    params.require(:dream).permit(:name, :content, :date)
  end

  def correct_user
    @dream = current_user.dreams.find_by(id: params[:id])
    redirect_to dreams_path if @dream.nil?
  end


end
