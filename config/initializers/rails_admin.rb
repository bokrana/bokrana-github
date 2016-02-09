RailsAdmin.config do |config|

  #config.audit_with :paper_trail, 'Passion', 'PaperTrail::Version'
  config.audit_with :paper_trail, 'Passionate', 'PaperTrail::Version'

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
  
  
RailsAdmin.config do |config|
  config.authorize_with do |controller|
    unless current_passionate.role == 'admin'
      redirect_to main_app.root_path
      flash[:error] = "You are not an admin"
    end
  end
end


module RailsAdmin
  class CSVConverter
    remove_const(:UTF8_ENCODINGS) if (defined?(UTF8_ENCODINGS))
    UTF8_ENCODINGS = [nil, '', 'utf8', 'utf-8', 'unicode', 'UTF8', 'UTF-8', 'UNICODE', 'utf8mb4', 'latin1']
  end
end




  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
     history_index
     history_show
  end
end
