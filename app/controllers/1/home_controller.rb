class HomeController < ApplicationController
helper_method :sort_column, :sort_direction

#=====================================================
 def index
    @title=""
    @passions = Passion.order("created_at desc").all
    #@comments = Comment.order('created_at DESC').limit(5)
respond_to do |format|
              format.html
              format.js
        end
    end

#===================================================
def me

end
#==================================================
def pending_comments
@next_comment = Comment.select("id","comment","created_at","vote","project_id").where("id > ?", params[:id]).order('id asc').first
unless @next_comment.nil? 
@next_project_name = Project.find_by_id(@next_comment.project_id).project_name
@next_project_img = Project.find_by_id(@next_comment.project_id).avatar.url(:small)
@pending_comment = @next_comment.attributes.merge("project" => @next_project_name , "img" => @next_project_img)
else
@pending_comment = []
end
respond_to do |format|
  format.json { render :json => @pending_comment }
end
end
#==============================================
protected
def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end
#=============================================
 private
def sort_column
  Project.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ? params[:direction] : "DESC"
end


end
