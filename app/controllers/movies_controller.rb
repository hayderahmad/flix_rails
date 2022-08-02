class MoviesController < ApplicationController
    before_action :require_signin
    before_action :set_movie, only: [:show, :edit, :update, :destroy]
    
    def index
        case params[:filter]
        when "upcoming"
          @movies = Movie.upcoming
        when "recent"
          @movies = Movie.recent
        when "released"
          @movies = Movie.released
        else
          @movies = Movie.all
        end

    end
    def show
        @fans = @movie.fans
        @genres = @movie.genres.order(:name)
        if current_user
            @favorite = current_user.favorites.find_by(movie_id: @movie.id)
        end
    end
    def edit
        
    end
    def update
        
        if @movie.update(movie_params)
            redirect_to movie_path(@movie), notice: "Movie successfully updated"
        else
            render :edit
        end
    end
    def destroy
        
        @movie.destroy
        redirect_to root_path, alert: "Movie successfully deleted!"
    end
    def create
        @movie = Movie.new(movie_params)
        if @movie.save

             redirect_to movie_path(@movie), notice: "Movie successfully created"
        else
            render :new 
        end
    end
    def new
        @movie = Movie.new
    end
    
    private
        def movie_params
            params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
        end
        def set_movie
            @movie = Movie.find_by(slug: params[:id])
        end
end
