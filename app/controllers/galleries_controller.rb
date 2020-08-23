class GalleriesController < ApplicationController

    def welcome
        @gallery = Gallery.new
    end

    def login
        gallery = Gallery.find_by(gallery_params)
        if gallery
            redirect_to new_gallery_session(gallery)
        else
            flash[:alert] = "Gallery does not exist yet. Please create one."
            redirect_to new_gallery_path
        end
    end

    def new
        @gallery = Gallery.new
    end

    def create
        gallery = Gallery.find_by(gallery_params)
        if gallery
            flash[:alert] = "gallery already exist, please login or use a different name"
            redirect_to welcome_path
        else
            gallery = Gallery.create(gallery_params)
            redirect_to new_gallery_user(gallery)
        end
    end

    def edit

    end

    def update

    end

    def show

    end

    def destroy

    end


    private

    def gallery_params
        params.require("gallery").permit(:name)
    end
end
