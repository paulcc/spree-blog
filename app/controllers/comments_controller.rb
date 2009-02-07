class CommentsController < ApplicationController
  helper Spree::BaseHelper
  helper BlogEntriesHelper

  # no comments without login first
  before_filter :login_required, :only => [:new,:create] 

  def new 
    @blog = BlogEntry.find(params[:blog_entry_id])
    @comment = Comment.new 
  end

  # save if all ok
  def create
    @blog = BlogEntry.find(params[:blog_entry_id])
    @comment = Comment.new :user => current_user, 
                           :body => params[:comment][:body],
                           :name => params[:comment][:name],
                           :uri  => params[:comment][:uri],
                           :blog_entry_id => params[:comment][:blog_entry_id],
                           :approved => false # should be done automatically in SQL

    if @comment.save
      flash[:notice] = 'Your comment was successfully submitted, and will be reviewed by an administrator soon.'
      redirect_to blog_entry_path(@blog)
    else
      @blog = BlogEntry.find(params[:comment][:blog_entry_id])
      render :action => "new"
    end
  end

end
