class PassionatesController < ApplicationController

before_action :confirm_logged_in , :the_owner, :except => [:index,:show,:new,:create]
helper_method :the_owner?

  def index
  end

  def show
  @passionate = Passionate.find(params[:id])
  @p2p = @passionate.passion_passionates
  @title= @passionate.name
respond_to do |format|
  format.html 
 format.js
  end  
  end




  def new
#sleep 5
@title="new passionate"
@passionate = Passionate.new
respond_to do |format|
  format.html 
 format.js
  end   
  end
#==============================================
def create
#sleep 2
#respond_to do |format|
#if @passionate.save
#  format.html { redirect_to root_path, notice: 'Your account was successfully created.' }
 # format.js
@title = "Errors!"
if passionate = Passionate.find_by_email(params[:passionate][:email]).present?
 respond_to do |format|
         format.html { redirect_to login_path , :notice => "This user already exist"}
         format.js {render :js => "$('.new-passionate-controller-error > p').html('This user already exist Try again or #{ ActionController::Base.helpers.link_to "Restore your password" , restor_password_path , {:remote => true, "data-toggle" =>  "modal",  :class => "controller-error-link", "data-no-turbolink" => "true"} } ').html_safe;$('.new-passionate-controller-error').fadeIn();$('#login-form #email , #login-form #password').addClass('input-error');" }
          end
     else
  @passionate = Passionate.new(passionate_params)
respond_to do |format|
      if @passionate.save
        PassionateMailer.welcome_email(@passionate, params[:passionate][:password]).deliver_now
        format.html { redirect_to root_path , notice: "Your account created successfully" }
        format.json { render json: @passionate, status: :created, location: @passionate }
        format.js {render :js => "$( '#ajax-modal' ).modal('hide');$('.modal-scrollable').trigger({ type: 'click' });swal({html:true, title: 'Your account created successfully', text: ' #{ ActionController::Base.helpers.link_to "Login" , new_passionate_path , :class => "sweet-link",:data => {no_turbolink: true}}', type: 'success'});" }
      else
       format.html {flash.now[:notice]="Save proccess coudn't be completed!" 
       render :new }  
       format.json { render json: @passionate.errors, status: :unprocessable_entity}
       format.js {render :js => "$('.new-passionate-controller-error > p').html(' #{ ActionController::Base.helpers.pluralize(@passionate.errors.count, "Error")} - #{@passionate.errors.full_messages.to_sentence.gsub("'", "\`")}').html_safe;$('.new-passionate-controller-error').fadeIn();$('#login-form #email , #login-form #password').addClass('input-error');" }
 #format.js {render :js => "swal({html:true, title: '#{ ActionController::Base.helpers.pluralize(@passionate.errors.count, "Error")}', text: '#{@passionate.errors.full_messages.to_sentence.gsub("'", "\`")}', type: 'error'});" }
      end
          end

end
end
#====================================================

  def edit
  @passionate = Passionate.find(params[:id])
  end


def update
@title = "Errors!"
@passionate = Passionate.find(params[:id])
@passionate.update_attributes(passionate_params)
if @passionate.save
    redirect_to  root_path ,:notice => "Your passionate has been created" 
else
 render :action => 'new'
end
end


 
  def delete
  end





##################################
private
def passionate_params
params.require(:passionate).permit(:email,:password,:name)
#:description,:phone,:website,:facebook_page,:facebook_personal_profile,:twitter,:skype,:youtube,:profile_image,
end


def the_owner?
if current_passionate ==  Passionate.find(params[:id])
return true
else
return false
end
end


def the_owner
 if current_passionate !=  Passionate.find(params[:id])
 redirect_to root_path
 end
end


end
