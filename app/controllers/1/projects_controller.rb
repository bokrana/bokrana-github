class ProjectsController < ApplicationController
before_filter :must_admin ,:except => [:show ,:index,:autocomplete,:search]
before_filter :project_must_exist , :user_info , :only => [:show]
#rescue_from Timeout::Error, :with => :rescue_from_timeout

#################################################3
def index
@projects = Project.order("created_at desc").page(params[:page]).per(5)
end

#######################################################
def search
@query = params[:q].to_s
unless @query.blank?
#@exact_project = Project.exact(@query).first
@projects = Project.search(@query).order("viewed_num desc")
@result_count = @projects.count 
@result_pages = @projects.page(params[:page]).per(5)
@search = Searchhist.find_by_search(@query)

if   @search.blank?  && @result_count >= 1
Searchhist.create(:hits => 1,:search => @query.downcase)
elsif @search.present? && @result_count  >= 1
@search.update_attributes(:hits => @search.hits + 1)
end
respond_to do |format|
              format.html
        end
else
redirect_to request.referer ,:notice => "لا يمكن الاستعلام عن حقل فارغ" 
end
end
#######################################################
def show
@title= @project.project_name
@comments = @project.comments.where(:active => nil).page(params[:page]).per(20).order('id DESC')
@comments_number = @comments.total_count
@comments_lefted = @comments.total_count - (@comments.offset_value + @comments.length) 
#if @comments_lefted == 1 then @comment_plural = "Comment" else @comment_plural = "Comments" end
###################
@bad_vote = @comments.where(:vote => 1).size ; 
@normal_vote = @comments.where(:vote => 2).size ; 
@good_vote = @comments.where(:vote => 3).size ; 
@just_comment = @comments.where(:vote => 4).size ; if @just_comment <= 1 then @user_just_comment = "User" else @user_just_comment = "Users" end
@total_vote = @bad_vote + @normal_vote + @good_vote
if @bad_vote > 0 then @bad_vote_percen = ((@bad_vote.to_f / @total_vote) * 100).floor else @bad_vote_percen = 0 end 
if @normal_vote > 0 then @normal_vote_percen = ((@normal_vote.to_f / @total_vote) * 100).floor else @normal_vote_percen = 0 end
if @good_vote > 0 then @good_vote_percen = ((@good_vote.to_f / @total_vote) * 100).floor else  @good_vote_percen = 0 end
if @just_comment > 0 then @just_comment_percen = ((@just_comment.to_f / @total_vote) * 100).floor else  @just_comment_percen = 0 end
###################
@comment = Comment.new( :project => @project )
###################
if @ip != "127.0.0.1"
@views = View.where(:ip => @ip , :country => @country , :city => @city)
if @views.size < 1 
@project.views.create({:ip => @ip , :country => @country , :city => @city , :hits => 1})
elsif @views.size == 1
@vfirst = @views.first
@vfirst.update_attribute(:hits , @vfirst.hits + 1 )
@exist = @project.views.where(:ip => @ip , :country => @country , :city => @city)
		if @exist.empty?
		@project.views << @views
		end
end
end
@id = @project.id
@views_num = @project.views.size
@project.update_attribute(:viewed_num, @views_num)
@v = View.find_by_sql(["select count (views.country) AS count,views.country from views , projects_views where views.id = projects_views.view_id AND projects_views.PROJECT_ID = ? group by views.country order by count desc", @id])
@views_country = @project.views.count(:group => "country")
@suggest = Project.where('id != ? ' , "#{@id}").order('RANDOM()').limit(5)
respond_to do |format|
format.html
format.js
end
end
############################################################
def new
@title="create new project"
@project = Project.new
@header = "اضافه مشروع جديد"
respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
end
end
########################################################
def create
@title = "Errors!"
@project = Project.new(project_params)
if @project.save
    redirect_to  project_path(@project) ,:notice => "Your account has been created" 
else
 render :action => 'new'
end

end
#######################################################
def edit
@title="تعديل المشروع"
@header = "تعديل المشروع" 
@project = Project.find_by_slug(params[:id])
end
#######################################################
def update
 @title = "Errors!"
@project = Project.find_by_slug(params[:id])
   if @project.update_attributes(project_params) 
          respond_to do |format|
          format.html {redirect_to project_path(@project)}
          format.xml  {render :xml  => @switches}
          format.json {render :json => @switches}
          format.any  {render :text => "Only HTML, JSON and XML are currently supported"}
          #format.js {render :js => { :result => 'success', :profile => profile_path(@profile) } }
     end

   else
   render :action => 'edit'
   end
end
########################################################
def destroy
@project = Project.find(params[:id])
@pname = @project.project_name
@project.remove_avatar!
@project.destroy
flash[:notice] = "project #{@pname} has been deleted"
respond_to do |format|
    format.html { redirect_to :action => "index"}
    format.js { render :nothing => true }
  end
end

##################################
protected
def must_admin
 redirect_to root_path unless logged_in?
end

#def rescue_from_timeout(exception)
#   redirect_to root_path
#  end

def user_info 
@ip = request.remote_ip
#geoip gem
@country = GeoIP.new('db/GeoIP.dat').country(@ip).country_name
if @country == "N/A" or @country == "" or @country == nil
begin
  #geocoder gem
 @country = request.location.country
rescue 
@country = ""
end
end
if @country == "N/A" or @country == "" or @country == nil
@country = "Unkown"
end

begin
  #Geo_ip gem
 @city=GeoIp.geolocation(@ip)[:city]
rescue 
@city = ""
end
if @city == "N/A" or @city == "" or @city == nil
begin
 @city = request.location.city
rescue 
@city = ""
end
 end
 if @city == "N/A" or @city == "" or @city == nil
 @city = GeoIP.new('../GeoLiteCity.dat').city(@ip).real_region_name
 end
 if @city == "N/A" or @city == "" or @city == nil
 @city = "Unkown"
end
#geo_ip
#@ipinfo=#GeoIp.geolocation(@ip)
#@country = "n"#@ipinfo[:country_name] if @ipinfo[:country_name].present?
#@city = "m"#@ipinfo[:city] if @ipinfo[:city].present?
#geocoder
#@country = request.location.country
#@city = request.location.city
end


def project_must_exist
@project = Project.find_by_slug(params[:id]) 
unless @project
redirect_to root_path
else
return @project
end
end

##################################
private
def project_params
params.require(:project).permit(:project_name,:project_desciption,:discount, :lock, :email, :phone, :facebook, :category, :tag_list, :avatar)
end

end
