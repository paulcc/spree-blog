class Admin::BlogEntriesController < Admin::BaseController
  require_role "admin" # You might want to remove this, and add security in the /config/easy_role_permissions.yml file
  layout 'admin'

  resource_controller

  index.before do 
    @blog_entries = BlogEntry.find(:all, :order => "created_at DESC")
  end

  create.response do |wants|
    wants.html { redirect_to admin_blog_entries_path }
  end

  update.response do |wants|
    wants.html { redirect_to admin_blog_entries_path }
  end

end
