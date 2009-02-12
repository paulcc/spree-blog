module BlogEntriesHelper

  # insert links for *nnnnn* codes
  # puts small thumbnails beneath the text (or do by paragraph?)
  # should this code be in the model? maybe not, since it's a view thing...
  def expand_sku(entry)
    matches = 0
    pics = ""
    text = entry.body
    entry.codes.each do |c|
      v = Variant.find_by_sku(c)
      if v.nil?
        "(invalid product #{c})"
      else
        matches += 1
        p = v.product
        pics << link_to((mini_image p), product_path(p), :style => "padding:6px", :title => p.name)
        text.gsub! /\*#{c}\*/, link_to(p.name, product_path(p))
      end
    end
    text + "<br/><p>" + pics + "</p>"
  end


end
