class MoviesController < ApplicationController
    def index
        if params[:query].present?
            sql_query = " \
              movies.title @@ :query \
              OR movies.synopsis @@ :query \
              OR directors.first_name @@ :query \
              OR directors.last_name @@ :query \
            "
            @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

            # FIRST WAY TO SEARCH AS 1 "ILIKE" OR 2 "@@" COMBINATIONS WORDS
        # if params[:query].present?
        #     # @movies = Movie.where(title: params[:query])
        #     @movies = Movie.where("title @@ :query OR synopsis @@ :query", query: "%#{params[:query]}%")
        else
            @movies = Movie.all
        end
    end
end
