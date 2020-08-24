class ArtworksController < ApplicationController
    before_action :authorized?

    def index
        artworks = Artwork.gallery_artworks(current_gallery)
        if params[:search]
            @artworks = artworks.search(params[:search])
        elsif params[:artist]
            @artworks = artworks.where(artist: params[:artist])
        else
            @artworks = artworks
        end
    end
    
    def new
        @artwork = Artwork.new
    end

    def create
        @artwork = Artwork.new(artwork_params)
        if @artwork.save
            redirect_to gallery_artworks_path(current_gallery)
        else
            flash[:alert] = "Please fill in the artwork title and artist name"
            render :new
        end
    end

    def edit
        set_artwork
    end

    def update
        set_artwork
        if @artwork.update(artwork_params)
        redirect_to gallery_artwork_path(current_gallery, @artwork)
        else
            flash[:alert] = "Please fill in the artwork title and artist name"
            render :edit
        end
    end

    def show
        set_artwork
    end

    def destroy
        set_artwork
        @artwork.destroy
        redirect_to gallery_artworks_path(current_gallery)
    end

    private

    def artwork_params
        params.require(:artwork).permit(:title, :artist, :edition, :year, :medium, :description, :availability, :commission, :gallery_id)
    end

    def set_artwork
        @artwork = Artwork.find_by_id(params[:id])
    end
end
