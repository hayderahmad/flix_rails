class ReviewsController < ApplicationController
    def index
        @movie=Movie.find(params[:event_id])
        @reviews = @movie.reviews
    end
end
