class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]

  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end
  def show
        
        @user = User.find(params[:id])
        @microposts = @user.microposts.paginate(page: params[:page])
        #@feed_items = current_user.feed.paginate(page: params[:page])
       
  end
  def new
        @user = User.new
      end
  def create
        @user = User.new(user_params)

        if @user.save
          #log_in @user  #new line
          remember @user       #  NEW LINE
          flash[:success] = "Welcome to the FiveYears!"    # NEW LINE
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
    if @user.update_attributes(user_params)#user_params
      flash[:success] = "Profile updated"
      redirect_to @user
      # Handle a successful update.
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

  # NEW PRIVATE METHOD
  private
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def user_params 
     params.require(:user).permit(:name, :email, :password, 
                                  :password_confirmation)

    # Before filters
    # Confirms a logged-in user.
    end

    def logged_in_user
      unless logged_in?

        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      #new line
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)

      #@micropost = current_user.microposts.find_by(id: params[:id])
      #redirect_to root_url if @micropost.nil?
    end
end
