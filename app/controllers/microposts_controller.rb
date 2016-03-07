class MicropostsController < ApplicationController
  before_action :find_micropost, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: :destroy
  
  #def index
  #@haikus = Haiku.by_votes
#end

#like function 
def like
  like = current_user.post_likes.new(value: params[:value], micropost_id: params[:id])
  if like.save
    redirect_to :back, notice: "Thank you for voting."
  else
    redirect_to :back, alert: "Unable to vote, perhaps you already did."
  end
end



  def index
    if params[:search]
          @microposts = Micropost.search(params[:search]).order("created_at DESC").paginate(page: params[:page])
        elsif params[:tag]
          @microposts = Micropost.tagged_with(params[:tag]).order("created_at DESC").paginate(page: params[:page])
        else
        #@microposts = Micropost.all.order("created_at DESC")
          @microposts = Micropost.order("created_at DESC").paginate(page: params[:page])
        #@users = User.paginate(page: params[:page])
    
          if logged_in?
            @micropost  = current_user.microposts.build
            #@feed_items = current_user.feed
          end
        end
  end

  def new 
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Post created!"
          redirect_to root_url #if use '@post', enter post/show screen

          else
          @feed_items = []
          render 'new'
        end
  end

  def show
    #@comment=Comment.new 
  end

  def edit
  end

  def update
    if @micropost.update(micropost_params)
      redirect_to @micropost
    else
      render 'edit'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path
  end


  private 

  def find_micropost
    @micropost = Micropost.find(params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(:title, :content, :all_tags, :picture)
  end

  def correct_user
              @micropost = current_user.microposts.find_by(id: params[:id])
              redirect_to root_url if @micropost.nil?
  end

  

end


