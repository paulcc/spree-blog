namespace :spree do
  namespace :extensions do
    namespace :blog do
      desc "Copies public assets of the Blog to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[BlogExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(BlogExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end