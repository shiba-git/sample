module SessionsHelper
    
    def log_in(user)
        session[:user_id] = user.id
    end
    
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: session[:user_id])
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if (user && user.authenticated?(:remember, cookies[:token]))
                log_in user
                @current_user = user
            end
        end
    end
    
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:token] = user.token
    end
    
    def logged_in?
        !current_user.nil?
    end
    
    def forget(user) 
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:token)
    end
    
    def logout 
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    
    def current_user?(user)
        user && user == current_user
    end
    
    def redirect_back_or(default)
        redirect_to(session[:forward_url] || default)
        session.delete(:forward_url)
    end
    
    def store_location
        session[:forward_url] = request.original_url if request.get?
    end
end
