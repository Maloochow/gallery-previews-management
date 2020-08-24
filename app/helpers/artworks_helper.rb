module ArtworksHelper

    def edit_link(artwork)
        link_to "Edit", edit_gallery_artwork_path(current_gallery, artwork)
    end

    def delete_link(artwork)
        link_to "Delete", gallery_artwork_path(current_gallery, artwork), method: 'DELETE'
    end

    def check_box(attribute)
        check_box_tag "#{attribute}", "#{attribute ? true : false}", attribute ? true : false 
    end
end
