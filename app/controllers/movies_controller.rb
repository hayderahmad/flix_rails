class MoviesController < ApplicationController
    def index
        @movies = Movie.released

    end
    def show
        @movie = Movie.find(params[:id])
    end
    def edit
        @movie = Movie.find(params[:id])
    end
    def update
        @movie = Movie.find(params[:id])
        @movie.update(movie_params)
        redirect_to movie_path(@movie)
    end
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        redirect_to root_path
    end
    def create
        @movie = Movie.create(movie_params)
        redirect_to movie_path(@movie)
    end
    def new
        @movie = Movie.new
    end
    
    private
        def movie_params
            params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name)
        end
end
