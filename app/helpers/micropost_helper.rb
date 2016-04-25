module MicropostHelper

    #define the synchronous tag panel once a user created a new tag, the tag panel will automatically show it
    def popular_tag(tags, classes)
      #count the number of the same tag to judge which is the biggest
      max = tags.sort_by(&:count).last
      #compare the tag's number, and change the tag's size corresponding to the comparison result 
      tags.each do |tag|
        index = tag.count.to_f / max.count * (classes.size-1)
        yield(tag, classes[index.round])
      end
    end
    
    #define the cloud tag's link's style, map it to tag's strip
    def tag_links(tags)
       tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ") 
    end



end