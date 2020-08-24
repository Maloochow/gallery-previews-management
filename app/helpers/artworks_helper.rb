module ArtworksHelper

    def edit_artwork(artwork)
        link_to "Edit", edit_gallery_artwork_path(current_gallery, artwork)
    end

    def delete_artwork(artwork)
        link_to "Delete", gallery_artwork_path(current_gallery, artwork), method: 'DELETE'
    end

    # def check_box(attribute)
    #     check_box_tag attribute, checked: attribute ? true : false 
    # end
end
