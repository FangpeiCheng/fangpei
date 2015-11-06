class UsersController < ApplicationController
  def show
        @user = User.find(params[:id])
        @microposts = @user.microposts    # NEW LINE
      end
  def new
        @user = User.new
      end
  def create
        secure_params = params.require(:user).permit(:name, :email, 
                                  :password, :password_confirmation)
        @user = User.new(secure_params)
        if @user.save
          remember @user       #  NEW LINE
          flash[:success] = "Welcome to the Sample App!"    # NEW LINE
          redirect_to @user  
        else
          render 'new'
        end
  end

  # UPDATED IMPLEMENTATION
  def destroy
            @micropost.destroy
            redirect_to root_url
  end

  # NEW PRIVATE METHOD
  private

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
