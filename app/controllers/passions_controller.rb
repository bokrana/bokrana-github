class PassionsController < ApplicationController

before_action :confirm_logged_in, :except => [:index,:show]
before_action :confirm_admin, :only => [:update,:destroy]
after_action :increase_views , :only => [:show]


  def index
  end

#====================================================

  def show
@passion = Passion.find(params[:id])
@passion_size = @passion.passionates.size
 respond_to do |format|
           format.html
           format.js 
end

  end
#==============================================
  def new
@title="create new passion"
@passion = Passion.new
respond_to do |format|
   if logged_in?
           format.html{}
           format.js {}
  else
     format.html {redirect_to login_path, notice: 'You have to login first.'}
      format.js{ render "access/login"}
end


end
  end
#==============================================
def create
 @passion = Passion.find_by_name(params[:passion][:name])
if @passion.present?
respond_to do |format|
         format.html { redirect_to login_path , :notice => "This passion already exist"}
         format.js {render :js => "$('.new-passion-controller-error > p').html('This passion already exist #{ ActionController::Base.helpers.link_to @passion.name , passion_path(@passion.id) , {:remote => true, "data-toggle" =>  "modal",  :class => "controller-error-link", "data-no-turbolink" => "true"} } ').html_safe;$('.new-passion-controller-error').fadeIn();" }
          end
 else
@passion = Passion.new(passion_params)
@passion.created_by = session[:passionate_id]
 respond_to do |format|
if @passion.save
    @title = "Passion created successfully"
    PassionPassionate.create(:passion => @passion , :passionate => current_passionate )
    format.html {redirect_to root_path, notice: 'Your passion has been created successfully.'}
    format.json { render json: @passion, status: :created, location: @passion }
    format.js {}
          else
       @title = "Errors!"
       format.html {flash.now[:notice]="Save process coudn't be completed!" 
       render :new }  
       format.json { render json: @passionate.errors, status: :unprocessable_entity}
       format.js {render :js => "$('.new-passion-controller-error > p').html(' #{ ActionController::Base.helpers.pluralize(@passion.errors.count, "Error")} - #{@passion.errors.full_messages.to_sentence.gsub("'", "\`")}').html_safe;$('.new-passion-controller-error').fadeIn();" }
      end
end

end

end
#====================================================

def new_passion_confirm
@passion = Passion.find(params[:passion_id])
@passion.visible   = false
@passion.save
end
#====================================================
  def edit
  @passion = Passion.find(params[:id])
  respond_to do |format|
           format.html{}
           format.js {}
end
  end

#====================================================

def update
@title = "Errors!"
@passion = Passion.find(params[:id])
@passion.update_attributes(passion_params)
if @passion.save
    redirect_to  root_path ,:notice => "Your passion has been updated" 
else
 render :action => 'new'
end
end


#====================================================

  def destroy 
  @passion = Passion.find(params[:id])
  respond_to do |format|
if @passion.destroy
    @passions = Passion.where(visible: true).all.order("created_at desc")
    @passion_count = @passions.size
           format.html{}
           format.js {}
 else
  @title = "Errors!"
       format.html {flash.now[:notice]="Delete process coudn't be completed!" 
        redirect_to  root_path}  
       format.json { render json: @passion.errors, status: :unprocessable_entity}
       format.js {render :js => 'toastr.error("Error while deleting passion", "", { "closeButton": true,"debug": false,"newestOnTop": true,
  "progressBar": false,"positionClass": "toast-top-center","preventDuplicates": false, "onclick": null,"showDuration": "5000","hideDuration": "1000",
  "timeOut": "5000","extendedTimeOut": "100000000", "showEasing": "swing","hideEasing": "linear","showMethod": "fadeIn","hideMethod": "fadeOut"})' }
     
      end       
           
           
           
end
end




##################################
private
def passion_params
params.require(:passion).permit(:name,:description,:passion_image)
end


def increase_views
@passion.update_attributes(:passionates_num => @passion.passionates_num + 1 )
end


end
