class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_passionate , :logged_in? , :admin?
#============================================




private

#======================================

def current_passionate
  return unless session[:passionate_id]
  @current_passionate ||= Passionate.find_by_id(session[:passionate_id])
end

#======================================

def logged_in?
 if session[:passionate_id]
 return true
else 
 return false
end
end

#=====================================
 def confirm_logged_in
   unless session[:passionate_id]
   flash[:warning]='Please login to continue'
   redirect_to(:controller => 'access',:action => 'login')
   return false
 else
   return true
 end
end
#=====================================
def admin?
if logged_in? && current_passionate.role == "admin"
 return true
else 
 return false
end
end
#=====================================

def confirm_admin
   unless logged_in? && current_passionate.role == "admin"
   flash[:warning]='Please login to continue'
   redirect_to(:controller => 'access',:action => 'login')
   return false
 else
   return true
 end
end


#=====================================
end
