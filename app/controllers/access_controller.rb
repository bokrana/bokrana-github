class AccessController < ApplicationController

before_action :confirm_logged_in, :except => [:login,:attempt_login,:restor_password,:restore_email]

  def login
  respond_to do |format|
  format.html 
  format.js 
  end   
  end

##################################################
def attempt_login
respond_to do |format|
 if params[:email].blank? || params[:password].blank?
    format.html { head :ok, content_type: "text/html" }
    format.js {render :js => "$('.login-controller-error > p').text('Please fill in all fields');$('.login-controller-error').fadeIn();$('#login-form #email , #login-form #password,#login-form2 #email , #login-form2 #password').addClass('input-error');" }

 elsif not_valid_email?(params[:email])
      format.html { redirect_to login_path , :notice => "Please enter a valid email address"}
      format.js {render :js => "$('.login-controller-error > p').text('Please enter a valid email address');$('.login-controller-error').fadeIn();$('#login-form #email , #login-form2 #email').addClass('input-error');" }

 elsif passionate = Passionate.authenticate(params[:email], params[:password])

         if passionate.lock == false && passionate.activate == false
           session[:passionate_id] = passionate.id
           session[:passionate_name] = passionate.name
                      format.html { redirect_to root_path , :notice => "You Logged In Successfully."}
                      format.js {
                                       flash[:success] = 'You Logged In Successfully.'
                                       render :js => "window.location.reload();"
                                        }
         elsif passionate.lock 
                      format.html { redirect_to root_path , :notice => "your account has been locked for some reasons Please contact us to solve your problem."}
                      format.js {render :js => "swal({title: 'Your account has been locked for some reasons', text: 'Please contact us to solve your problem.', type: 'error'});" }
                                    
         elsif passionate.activate == true
           @passionate = passionate
            format.html { redirect_to root_path, :notice => 'try again #{ActionController::Base.helpers.link_to "Activate your account", access_activate_url_path(@passionate),:class=>"sweet-link" :data => {no_turbolink: true} }'.html_safe}                          
         end

 else
      if passionate = Passionate.find_by_email(params[:email])
           format.html { redirect_to login_path , :notice => "Your password is incorrect"}
           format.js {render :js => "$('.login-controller-error > p').html('Your password is incorrect Try again or #{ ActionController::Base.helpers.link_to "Restore your password" , restor_password_path , {:remote => true, "data-toggle" =>  "modal",  :class => "controller-error-link", "data-no-turbolink" => "true"} } ').html_safe;$('.login-controller-error').fadeIn();$('#login-form #password,#login-form2 #password').addClass('input-error');" }
         
      else
             format.html { redirect_to login_path , :notice => "No account found with that email address"}
             format.js {render :js => "$('.login-controller-error > p').text('No account found with that email address');$('.login-controller-error').fadeIn();$('#login-form #email , #login-form2 #email').addClass('input-error');" }
      end
     
 end

 end
end
#####################################################
def logout
    reset_session
    session[:passionate_id] = nil
    session[:passionate_name] = nil
    flash[:success] = "You logged out successfully"
    redirect_to root_path 
end
#####################################################
def restor_password
  @title = "Restore Your Password"
  respond_to do |format|
  format.html 
  format.js 
end

end
#####################################################
def restore_email
if passionate = Passionate.find_by_email(params[:email]).present?
 respond_to do |format|
         format.html { redirect_to login_path , :notice => "This user already exist"}
         format.js {render :js => "$('.restore-password-controller-error > p').html('This user already exist 00 Try again or #{ ActionController::Base.helpers.link_to "Restore your password" , restor_password_path , {:remote => true, "data-toggle" =>  "modal",  :class => "controller-error-link", "data-no-turbolink" => "true"} } ').html_safe;$('.restore-password-controller-error').fadeIn();" }
          end
end
end

#####################################################



private

  def not_valid_email?(email)
    unless email =~ /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  return true
    end
  end







end
