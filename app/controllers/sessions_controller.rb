class SessionsController < ApplicationController
      
      def new
      end

      def create
        #the email will be transferred in to downcase
        user = User.find_by(email: params[:session][:email].downcase)  
        #authenticate user
        if user && user.authenticate(params[:session][:password])
          remember user 
          flash[:success] = 'Logged in successfully!'
          redirect_to user
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
      end
      #log out 
      def destroy
        log_out if logged_in?
        flash[:success] = 'Logged out!'
        redirect_to root_url
      end 
end
