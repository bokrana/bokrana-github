class PassionPassionatesController < ApplicationController

before_action :confirm_logged_in , :except => [:new]
before_action :confirm_permission ,:only => [:edit,:update,:destroy]

  def new
@title="join passion"
respond_to do |format|
 if logged_in? 
      @passion = Passion.find_by_id(params[:passion_id])
    if @passion.passionates.where(:id => session[:passionate_id]).empty?
     @p2p = PassionPassionate.new
      format.html {}
      format.js  {}
    else 
      format.html {redirect_to root_path, notice: 'You have been already join this passion.'}
      format.js{
                    render :js => "$('.modal-scrollable').trigger({ type: 'click' });swal({ title: 'You have been already join this passion.', text: '', type: 'error'});" 
                       }
     end
else
     format.html {redirect_to login_path, notice: 'You have to login first.'}
      format.js{ render "access/login"}
end
  end


  end
##########################################
  def create
  @passion = Passion.find_by_id(params[:passion_id])
  @p2p = PassionPassionate.new(:passion => @passion , :passionate => current_passionate,:price_from => p2p_params[:price_from],:price_to => p2p_params[:price_to] ,:discount => p2p_params[:discount],:note => p2p_params[:note] )
respond_to do |format|
    if @p2p.save
      @passion.update_attributes( :passionates_num => @passion.passionates_num + 1 )
      format.html { redirect_to root_path, notice: 'You have been successfully join this passion.' }
      format.js   { render :file => "/layouts/swal_error.js.erb", :locals => {:title => "You have been successfully join this passion." ,:text => ""}}
      #format.json { render json: @p2p, status: :created }
    else
      format.html { render action: "new" }
      format.js   { render action: "new"}
      #format.json { render json: @p2p.errors, status: :unprocessable_entity }
    end
  end

  end




def edit
@title="" 
@p2p = PassionPassionate.find_by_id(params[:id])
  end

 def update
end

 def destroy
p2p = PassionPassionate.find_by_id(params[:id])
p2p.destroy

redirect_to root_path ,:notice => "Your passionate has been created" 
 end





#=============================================================
private
def p2p_params
params.require(:passion_passionate).permit(:price_from,:price_to,:discount,:note)
end

def confirm_permission
if current_passionate.id !=  PassionPassionate.find_by_id(params[:id]).passionate_id
 redirect_to root_path , notice: 'no.'
end
end



end
