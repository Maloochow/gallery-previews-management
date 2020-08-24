class Artwork < ApplicationRecord
    belongs_to :gallery

    validates :title, presence: true
    validates :artist, presence: true

    scope :gallery_artworks, -> (id) { where(gallery_id: id)}
    scope :search, -> (title) { where("title LIKE ?", "%#{title}%")}
end
