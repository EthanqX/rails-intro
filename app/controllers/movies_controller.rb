class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      # @all_ratings = Movie.all_ratings
      # ratings_list = params[:ratings]&.keys || session[:ratings] || Movie.all_ratings
      # ratings_to_show_hash = Hash[ratings_list.collect { |item| [item, "1"] }]
      # @sort_by = params[:sort_by]
      # @movies = Movie.with_ratings(@ratings_to_show, @sort_by)

      # @all_ratings = Movie.all_ratings
      # @ratings_to_show = params[:ratings_hash]&.keys || Movie.all_ratings
      # @ratings_to_show_list = @ratings_to_show
      # @sort_by = params[:sort_by] || session[:sort_by] || 'id'

      # if params[:ratings_list]
      #   @ratings_to_show_list = params[:ratings_list]
      # elsif session[:ratings_to_show_list] 
      #   @ratings_to_show_list = session[:ratings_to_show_list]
      # end
      
      # @movies = Movie.with_ratings(@ratings_to_show_list, @sort_by) 

      # session['ratings_to_show_list'] = @ratings_to_show_list
      # session['sort_by'] = @sort_by
      @all_ratings = Movie.all_ratings
      ratings_list = params[:ratings]&.keys || session[:ratings] || Movie.all_ratings
      sort_by = params[:sort_by] || session[:sort_by] || 'id'
      @ratings_to_show_hash = Hash[ratings_list.collect { |item| [item, "1"] }]
      @movies = Movie.with_ratings(ratings_list, sort_by)
      @sort_by = sort_by
      session['ratings'] = params[:ratings]&.keys || session[:ratings] || Movie.all_ratings
      session['sort_by'] = @sort_by
    end
  
    def new
      # default: render 'new' template
    end
  
    def create
      @movie = Movie.create!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    end
  
    def edit
      @movie = Movie.find params[:id]
    end
  
    def update
      @movie = Movie.find params[:id]
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    end
  
    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end



  end