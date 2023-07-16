class MoviesController < ApplicationController
  def index
    @facade = MovieFacade.new(params)
  end

  def show
    @facade = MovieFacade.new(params)
  end
end
