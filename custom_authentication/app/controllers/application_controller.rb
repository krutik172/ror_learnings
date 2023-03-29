class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged_in? 
    before_action :require_login?

    def logged_in?
        session[:current_user_id] 
    end  

    private 
    def current_user 
        @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end

    def require_login?
        unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to login_path # halts request cycle
        end
    end
end
