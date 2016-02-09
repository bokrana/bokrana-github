class AimanistratorsController < ApplicationController
before_filter :already_log_in, :only => [:create, :access_code, :login, :access]
before_filter :must_admin, :only => [:destroy]
before_filter :check_admin_session , :only => [:access_code]
before_filter :must_from_egypt

def login
redirect_to aimanistrator_access_code_path(current_admin) if current_admin
@title="Administrator Login"
end

  def create
    if admin = Admin.authenticate(params[:username], params[:password])
       if admin.lock == false && admin.active == false
         session[:aimanistrator_id] =admin.id
         admin.update_attributes(:failed_login_num => 0 ) if admin.failed_login_num > 0
         @admin = admin
         @code = SecureRandom.urlsafe_base64(6)
         admin.update_attribute(:access_code , @code)
         AdminAccessCode.access_code(@admin, @code).deliver
         redirect_to aimanistrator_access_code_path(@admin)
       elsif admin.active
         @admin = admin
         redirect_to root_path, :notice => "Another admin ogin please log off first and then try again #{ActionController::Base.helpers.link_to "disconnect all connections", aimanistrator_disconnect_request_path(@admin), :data => {no_turbolink: true} }".html_safe
       elsif admin.lock
         redirect_to root_path , :notice => "your account has been blocked please contact system administrator to solve this issue"
       end
    elsif admin = Admin.find_by_username(params[:username])
       if admin.lock 
          redirect_to root_path , :notice => "your account has been blocked - you enter incorrect password five times"
       elsif admin.failed_login_num >= 4 
         @admin = admin
         @ip = request.remote_ip 
         admin.lock = true
         AdminAccessCode.admin_lock(@admin, @ip).deliver if admin.save
         redirect_to root_path , :notice => "your account has been blocked - you enter incorrect password five times "
         else
         admin.update_attributes(:failed_login_num => admin.failed_login_num + 1 )
         redirect_to aimanistrator_login_path, :alert => "Invalid Password your account will be blocked after another #{5 - admin.failed_login_num} attempts"
       end
    else
         flash[:error] = "Invalid username and password"
         redirect_to aimanistrator_login_path
    end
  end


def disconnect_request
@admin = Admin.find_by_id(params[:aimanistrator_id])
Admin.generate_token(@admin.id)
redirect_to aimanistrator_login_path , :notice => "Please login to your email to disconnect all current session with your account "
end

def disconnect_all
@title="Error"
if @admin=Admin.find_by_reactivate_url(params[:aimanistrator_id])
@admin.active = false
@admin.save
redirect_to aimanistrator_login_path  :notice => "you can now connect to administrator page"
end
end

def access_code
@title="Enter Access Code"
@admin = Admin.find_by_id(params[:aimanistrator_id])
@name = @admin.name
@photo = @admin.photo
@lastlogin = @admin.last_login
@country = @admin.country
@ip = @admin.ip
end

def resend_access_code
@admin = Admin.find_by_id(params[:aimanistrator_id])
@code = SecureRandom.urlsafe_base64(6)
@admin.update_attribute(:access_code , @code)
AdminAccessCode.access_code(@admin, @code).deliver
render :nothing => true
end


def cancle_access
reset_session 
redirect_to root_path
end

def access
admin = Admin.find_by_id(params[:aimanistrator_id])
@access_code = (params[:access_code]).strip
 if admin.access_code == @access_code
  admin.update_attribute(:active , true)
  admin.update_attribute(:last_login , Time.now.to_s(:db))
  @ip = request.remote_ip
  admin.update_attribute(:ip , @ip )
#geoip gem
@country = GeoIP.new('db/GeoIP.dat').country(@ip).country_name.upcase
if @country == "N/A" or @country == "" or @country == nil
begin
 #Geo_ip gem
 @country = GeoIp.geolocation(@ip)[:country_name]
rescue 
@country = "UNKNOWN"
end
end
  admin.update_attribute(:country , @country ) if @country.present?
  AdminLogin.admin_login(admin).deliver
flash[:success] = "You successfully logged in"
redirect_to root_path
else
redirect_to aimanistrator_access_code_path, :notice => "invaled access code"
 end
end

def destroy
    current_admin.update_attributes(:access_code => nil)
    admin = current_admin
    admin.active = false
    if admin.save
    reset_session
    session[:aimanistrator_id] = nil
    flash[:success] = "You logged out successfully"
    redirect_to root_path
    else
    redirect_to root_path, :notice => "cannot logged out"
  end
end
#####################
protected
 def already_log_in
  redirect_to root_path , :notice => "you are already logged in" if logged_in?
 end   
 
 def check_admin_session
 redirect_to aimanistrator_login_path , :notice => "Login First please " unless current_admin
 end
 
 def must_admin
 redirect_to aimanistrator_login_path,:notice => "you are not allow to see this page please login first" unless logged_in?
 end
 
 def must_from_egypt
@ip = request.remote_ip
#geoip gem
@country = GeoIP.new('db/GeoIP.dat').country(@ip).country_name.upcase
if @country == "N/A" or @country == "" or @country == nil
begin
 #Geo_ip gem
 @country = GeoIp.geolocation(@ip)[:country_name]
rescue 
@country = ""
end
end
if (@ip == '127.0.0.1')
 return
elsif (@country != "EGYPT" )
 redirect_to root_path
 end
 end
end
