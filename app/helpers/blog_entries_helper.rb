module BlogEntriesHelper

  # insert links for *nnnnn* codes or *nnnnn:text*
  # puts single large image (chosen randomly from mentioned products) by the text
  # should this code be in the model? maybe not, since it's a view thing...
  def expand_sku(entry)
    matches = 0
    products = []
    text = entry.body
    entry.codes.each do |c,n|
      v = Variant.find_by_sku(c)
      if v.nil?
        "(invalid product #{c})"
      else
        matches += 1
        p = v.product
        products << p
        if n.blank? 
          text.gsub! /\*#{c}\*/,      link_to(p.name, product_path(p))
        else 
          text.gsub! /\*#{c}:#{n}\*/, link_to(n,      product_path(p))
        end
      end
    end
    ## mini_pics = products.each do |p| 
    ##               link_to((mini_image p), product_path(p), :style => "padding:6px", :title => p.name)
    ##             end
    ## "<image src=text + "<br/><p>" + mini_pics.uniq.join + "</p>"
   
    unless products.empty?  
      featured = products[rand(products.length)]
      text.gsub! /^\s*<p>/, ""
      "<p>" + (link_to (product_image featured), (product_path featured), :style => "float:left; padding:6px", :title => featured.name) + text
    end
  end


end
