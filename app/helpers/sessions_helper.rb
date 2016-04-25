module SessionsHelper
	    
      def log_in(user)
        session[:user_id] = user.id
      end
      # remembers a user in the following session.
      def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
      end
      # returns the user using the remember token cookie.
      def current_user
        if (user_id = cookies.signed[:user_id])
           @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
           user = User.find_by(id: user_id)
           if user && user.authenticated?(cookies[:remember_token])
            log_in user#new line
            @current_user = user
          end
        end
      end
      # Returns true if logging in, false otherwise.
      def logged_in?
        !current_user.nil?
      end
      # Judge whether the user is current user, returns true if so.
      def current_user?(user)
        user == current_user
      end

      # Forgets a persistent session.
      def forget(user)
          user.forget
          cookies.delete(:user_id)
          cookies.delete(:remember_token)
      end

      # the current user logs out .
      def log_out
          forget(current_user)
          @current_user = nil
      end

      #ensure log in
      def logged_in_user
        unless logged_in?
          flash[:notice] = "Please log in!"
          redirect_to login_url
        end
    end 
end
