class ViewingPartiesController < ApplicationController
  before_action :find_user

  def new
    movie_id = params[:movie_id].to_i
    @movie = MovieFacade.new(id: movie_id).movie
    @users = User.other_users(@user.id)
  end

  def create
    movie_party = Party.new(party_params)
    if movie_party.save
      make_host(movie_party)
      create_user_parties(movie_party)
      # redirect_to user_path(@user)
      redirect_to dashboard_path
    else
      flash[:error] = "Error: All fields must be filled in!"
      redirect_to new_user_movie_viewing_party_path(@user, params[:movie_id])
    end
  end

  private

  def party_params
    params.permit(:duration, :party_date, :party_time, :movie_id)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_party_user(id)
    User.find(id)
  end

  def make_host(party)
    host = find_user
    UserParty.create(user_id: host.id, party_id: party.id, is_host: true)
  end

  def create_user_parties(party)
    params[:user_ids].compact_blank.each do |user_id|
      UserParty.create(user_id: find_party_user(user_id).id, party_id: party.id, is_host: false)
    end
  end
end
