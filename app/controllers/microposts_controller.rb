class MicropostsController < ApplicationController
  before_action :find_micropost, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: :destroy
  def index
    if params[:search]
          @microposts = Micropost.search(params[:search]).paginate(page: params[:page]).order("created_at DESC")
        elsif params[:tag]
          @microposts = Micropost.tagged_with(params[:tag]).paginate(page: params[:page])
        else
        #@posts = Post.all.order("created_at DESC")
    @microposts = Micropost.paginate(page: params[:page]).order("created_at DESC")
    #@users = User.paginate(page: params[:page])
    
    if logged_in?
            @micropost  = current_user.microposts.build
            @feed_items = current_user.feed
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


