class Admin::CommentsController < Admin::BaseController
  require_role "admin" # You might want to remove this, and add security in the /config/easy_role_permissions.yml file
  layout 'admin'

  resource_controller

  belongs_to :blog_entry		# ?? 

  index.before do 
    @blog = BlogEntry.find(params[:blog_entry_id])
  end

  update.response do |wants|
    wants.html { redirect_to admin_blog_entry_comments_path }
  end

  def approve
    c = Comment.find(params[:id])
    c.approved = true 
    c.save
    redirect_to [:admin, c.blog_entry, :comments]
  end

end
