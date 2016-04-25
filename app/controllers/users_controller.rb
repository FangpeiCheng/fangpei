class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  


  def index
    #return the result for searching
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    #@users = User.all#before version
    #@users = User.paginate(page: params[:page])#new version
    elsif params[:id]
      # get all records with id less than 'our last id'
      # and limit the results to 5
      @users = User.where('id < ?', params[:id]).limit(6)
    else
      @users = User.limit(6)
    end
    respond_to do |format|
      format.html
      format.js   #render index.js.erb
    end
  end

  def show
        
        @user = User.find(params[:id])
        #@microposts = @user.microposts.paginate(page: params[:page])
        @microposts = @user.microposts
        #@feed_item = current_user.feed_post.paginate(page: params[:page])
        @feed_item = @user.feed_post
  end

  def new
        @user = User.new
  end

  def create
        @user = User.new(user_params)

        if @user.save
          
          remember @user      
          flash[:success] = "Welcome to the FiveYears!" 
          redirect_to @user  
        else
          render 'new'
        end
  end

  def edit
    @user = User.find(params[:id])
  end

  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  
  # UPDATED IMPLEMENTATION
   def update
     @user = User.find(params[:id])
     #a successful update.
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      
    else
      render 'edit'
    end
  end
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  #private method
  private
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def user_params 
     params.require(:user).permit(:name, :email, :password, 
                                  :password_confirmation)

    # Before filters, ensure a logged-in user.
    end

    def logged_in_user
      unless logged_in?

        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # ensure the correct user.
    def correct_user
      
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)

      #@micropost = current_user.microposts.find_by(id: params[:id])
      #redirect_to root_url if @micropost.nil?
    end
end
