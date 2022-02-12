class AccountActivationsController < ApplicationController
    
    def edit 
        user = User.find_by(email: params[:email])
        if user && !user.activation? && user.authenticated?(:activation, params[:id])
            user.activate
            log_in user 
            activated_at
            redirect_to user
        else
            flash[:danger] = "Invalid activation link"
            redirect_to root_url
        end
    end
end
