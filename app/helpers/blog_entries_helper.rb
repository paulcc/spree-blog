module BlogEntriesHelper

  # insert links for *nnnnn* codes
  # distributes small thumbnails to left and right
  # attempts to set min height for the BB
  def expand_sku(text)
    matches = 0
    pics = ""
    text.gsub!(/\*(\w+)\*/) do |s|
      v = Variant.find_by_sku($1)
      if v.nil?
        "(deleted product #{$1})"
      else
        matches += 1
        p = v.product
        pics << link_to((mini_image p), p.permalink, :style => "padding:6px", :title => p.name)
        link_to(p.name, p.permalink)
      end
    end
    text + "<br/>" + pics
  end


end
