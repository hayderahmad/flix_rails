class ApplicationController < ActionController::Base
    def require_signin
        unless current_user
          session[:intended_url] = request.url
          redirect_to new_session_url, alert: "Please sign in first!"
        end
    end

    def current_user
         User.find(session[:user_id]) if session[:user_id]
    end
    def current_user_admin?
        User.find(session[:user_id]).admin
    end
    def require_correct_user
        @user = User.find(params[:id])
        unless current_user == @user
          redirect_to root_url
        end
    end
    helper_method :current_user
    helper_method :current_user_admin?
    helper_method :require_correct_user
end
