class BlogEntriesController < Spree::BaseController
  # helper Spree::BaseHelper

  resource_controller
  actions :show, :index

  # no comments without login first
  before_filter :login_required, :only => [:store_comment] 

  index.before do
    # add pagination??
    @blogs = BlogEntry.find :all, :order => "created_at DESC"
  end

  show.before do
    @blog = BlogEntry.find params[:id]
  end

  def new_comment
    @blog = BlogEntry.find(params[:id])
    @comment = Comment.new :user => current_user
  end

  # save if all ok
  def store_comment 
    @comment = Comment.new :user => current_user, 
                           :body => params[:comment][:body],
                           :name => params[:comment][:name],
                           :uri  => params[:comment][:uri],
                           :blog_entry_id => params[:comment][:blog_id],
                           :approved => false # should be done automatically in SQL

    if @comment.save
      flash[:notice] = 'Your comment was successfully submitted, and will be reviewed by an administrator soon.'
      redirect_to :action => 'index'
    else
      @blog = BlogEntry.find(params[:comment][:blog_id])
      render :action => "new_comment"
    end
  end

end
