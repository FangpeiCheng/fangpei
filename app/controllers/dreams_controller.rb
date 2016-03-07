class DreamsController < ApplicationController
	#before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  before_action :correct_user,   only: [:edit, :update, :destory]
  before_action :find_dream, only: [:show, :edit, :update, :destroy]
  #before_action :correct_user,   only: :destroy
  def index
          @dreams = Dream.order("created_at DESC").paginate(page: params[:page])
          if logged_in?
            @dream  = current_user.dreams.build
            @feed_items = current_user.feed.paginate(page: params[:page])
          end
        
    end
   
    def new
    	@dream = Dream.new

    end
    def show
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
