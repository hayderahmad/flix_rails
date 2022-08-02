class Movie < ApplicationRecord
    before_save :set_slug


    has_many :reviews, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :fans, through: :favorites, source: :user
    has_many :characterizations, dependent: :destroy
    has_many :genres, through: :characterizations
    validates :title, :released_on, :duration, presence: true, uniqueness: true
    validates :description, length: { minimum: 25 }
    validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
    RATINGS = %w(G PG PG-13 R NC-17)      
    validates :rating, inclusion: { in: RATINGS }
    validates :image_file_name, format: {
        with: /\w+\.(jpg|png)\z/i,
        message: "must be a JPG or PNG image"
      }

      scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
      scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
      scope :recent, ->(max=3) { released.limit(max) }
    
    def average_stars
        reviews.average(:stars) || 0.0
    end
    def to_param
        slug
    end
    private
        def set_slug
            self.slug = title.parameterize
        end
        
end
