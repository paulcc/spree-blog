# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class BlogExtension < Spree::Extension
  version "1.0"
  description "Simple blog facility"
  url "git://github.com/paulcc/spree-blog.git"

  define_routes do |map|
    map.resources :blog_entries, :as => 'the-blog', :has_many => :comments
    # map.connect '/the-blog/:year/:month/:day', :controller => 'blog_entry', :action => 'index'
    map.namespace :admin do |admin|
      admin.resources :blog_entries, :has_many => :comments
    end  
  end
  
  def activate
    # admin.tabs.add "Blog", "/admin/blog", :after => "Layouts", :visibility => [:all]

    # Add a link to the blog administration page on the configuration page
    Admin::ConfigurationsController.class_eval do
      before_filter :add_blog_links, :only => :index
    
      def add_blog_links
        @extension_links << {:link => admin_blog_entries_path, :link_text => t('blog_management'), :description => t('blog_management_description')}
      end
    end
    
    # Add blog mention access functionality to the product model
    Product.class_eval do
      has_many :blog_entries
    end
  end
  
  def deactivate
    admin.tabs.remove "Blog"
  end
  
end
