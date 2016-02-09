class CommentsController < ApplicationController

def index
 @comments = Comment.all
 @project = Project.find_by_slug(params[:project_id])
  respond_to do |format|
  format.html # => ‘views/index.html.erb’ inside layout template on HTTP Request
  format.js # => renders ‘views/index.js.erb’
  end      
end

def create
@project = Project.find_by_slug(params[:project_id])
@comment = @project.comments.create(comment_params)
@comment.ip = request.remote_ip
@ipinfo=GeoIp.geolocation(@comment.ip)
@comment.country = @ipinfo[:country_name] if @ipinfo[:country_name].present?
@comment.city = @ipinfo[:city] if @ipinfo[:city].present?
 if @comment.save
    @comments_num = @project.comments.count
    @project.update_attribute(:comments_num, @comments_num)
    #render :json =>  "created".to_json, :status => :created
    #render :json => '{status: "created"}',:status => :created
    render nothing: true , :status => :created
  else
  render :json => {:error => @comment.errors.full_messages} ,:status => :unprocessable_entity 
  end
end
 
  def destroy
    @project = Project.find_by_slug(params[:project_id])
    @comment = @project.comments.find(params[:id])
    respond_to do |format|
   if @comment.destroy
    format.js
   else
    format.html { redirect_to project_path(@project) , notice: 'Error while delete this comment'}
  end
 end
end

def lastcom
@comments = Comment.order('created_at DESC').limit(19).where("created_at > ?",session[:last_comment])
if @comments.size > 0
session[:last_comment] = @comments.first.created_at
render :layout => false
else
render :nothing => true
end
end


private
def comment_params
    params.require(:comment).permit(:project_id,:email,:vote,:comment)
end


end
