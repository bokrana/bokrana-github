class PagesController < ApplicationController
  

 def home
    @title="Bokrana"
    @passions = Passion.where(visible: true).all.order("created_at desc")
    @passion_count = @passions.size
    @pssionate_count = Passionate.all.size
    #@comments = Comment.order('created_at DESC').limit(5)
 respond_to do |format|
              format.html
              format.js {render inline: "location.reload();" }
     end
  end

#==================================================

def subscribe
@title = "Errors!"
respond_to do |format|
if params[:email].blank? || params[:email] == "your@email.com"
         format.html { redirect_to login_path , :notice => "ooooooooo"}
         format.js {render :js => "swal({ title: 'oooooooooo' , type: 'error', animation: false});" }

 elsif not_valid_email?(params[:email])
      format.html { redirect_to login_path , :notice => "please enter a valid email address"}
      format.js {render :js => "swal({ title: 'Please enter a valid email address' , type: 'error'});" }

elsif  MailList.find_by_email(params[:email]).present?
         format.html { redirect_to login_path , :notice => "This email already subsribed to our email newsletter"}
         format.js {render :js => "swal({ title: 'This email already subsribed to our email newsletter' , type: 'error'});" }
else
@mail_list = MailList.new(mail_params)
respond_to do |format|
if @mail_list.save
    format.html {redirect_to root_path, notice: 'Your subsribed to our email newsletter.'}
    format.js  {}
   else
    format.html {redirect_to root_path, notice: 'Error while subsribe to mail list try again later.'}
    format.json { render json: @passionate.errors, status: :unprocessable_entity}
    format.js {render :js => "swal({html:true, title: '#{ ActionController::Base.helpers.pluralize(@mail_list.errors.count, "Error")}', text: '#{@mail_list.errors.full_messages.to_sentence.gsub("'", "\`")}', type: 'error'});" }
end
end

end
end

end

#=================================================485C75-99C65F

def search
@query = params[:q].to_s
respond_to do |format|
unless @query.blank?
@passions = Passion.search(@query)
@passionates = Passionate.search(@query)
@passion_count = @passions.size
@pssionate_count = @passionates.size
              format.html 
              format.js
else
             format.js {render :js => "swal({ title: 'Cannot search for blank field', text: '', type: 'error'});" }
end
end
end

#===================================================

def terms
@title = "terms and conditions"
respond_to do |format|
              format.html 
              format.js
end



end
#===================================================
#items = Passion.find_by_sql("select name , id , 'a' as 'table' from passions where lower(name) like '%#{params[:q]}%'  UNION 
#select name , id , 'p' as 'table' from passionates where lower(name) like '%#{params[:q]}%' LIMIT 10")|| ''

def autocomplete
@query = params[:q].to_s
items = Passion.autocomplete(@query)
respond_to do |format|
    format.json { render json: items }
  end
end


#===================================================
private
def mail_params
params.permit(:email)
end



  def not_valid_email?(email)
    unless email =~ /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  return true
    end
  end




end
