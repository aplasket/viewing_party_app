class Party < ApplicationRecord
  validates :duration, presence: true
  validates :party_date, presence: true
  validates :party_time, presence: true

  has_many :user_parties
  has_many :users, through: :user_parties

  def movie_details
    movie = MovieFacade.new({id: self.movie_id}).movie

    party_info = {
      title: movie.title,
      movie_id: movie.id,
      duration: duration,
      party_date: party_date,
      party_time: party_time,
      image: "https://image.tmdb.org/t/p/original#{movie.poster_path}"
    }
  end
end
