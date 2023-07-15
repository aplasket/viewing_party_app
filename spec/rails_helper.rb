# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start

require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.fixture_path = Rails.root.join('/spec/fixtures')
  #
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  #
  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false
  #
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!
  #
  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  #
  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<TMDB_API_KEY>") { ENV["TMDB_API_KEY"] }
  config.configure_rspec_metadata!
  config.default_cassette_options = { :allow_playback_repeats => true }
  config.default_cassette_options = { re_record_interval: 2.minutes } #7.days }
end

def test_movie_cast
  @movie_cast_data = [{
    adult: false,
    gender: 2,
    id: 884,
    known_for_department: "Acting",
    name: "Steve Buscemi",
    original_name: "Steve Buscemi",
    cast_id: 7,
    character: "Mr. Pink",
    credit_id: "52fe424ac3a36847f8012cc9",
    order: 4
  }]
end

def test_movie_credits
  @movie_credits_data = {
    id: 333,
    cast: [
      {
            adult: false,
            gender: 2,
            id: 86213,
            known_for_department: "Acting",
            name: "Rahul Khanna",
            original_name: "Rahul Khanna",
            popularity: 2.787,
            cast_id: 2,
            character: "Rahul Seth",
            credit_id: "52fe4239c3a36847f800d5bf",
            order: 0
      }
          ],
    crew: [
      {
        adult: false,
        gender: 1,
        id: 4760,
        known_for_department: "Directing",
        name: "Deepa Mehta",
        original_name: "Deepa Mehta",
        popularity: 2.645,
        credit_id: "52fe4239c3a36847f800d5bb",
        department: "Directing",
        job: "Director"
      }
    ]
  }

end

def test_movie_reviews
  @movie_reviews_data = {
    id: 500,
    page: 1,
    results: [
        {
            author: "talisencrw",
            author_details: {
                name: "",
                username: "talisencrw",
                avatar_path: "/https://secure.gravatar.com/avatar/cbcc9350415274a3c68399bd37ca3ebc.jpg",
                rating: 10.0
            },
            content: "This unique take on the heist-film-gone-wrong was excellent--stylish and intelligently made, yet very funny and inexpensive. Tarantino's accolades from giving American cinema the resuscitation it needed mirrors what has happened, at least since the 70's, with Martin Scorsese's 'Mean Streets', both in terms of entertaining violence and usage of music in the scoring of films. I greatly thank Harvey Keitel for taking a chance on Tarantino back then--It paid off in spades.",
            created_at: "2016-05-14T19:05:28.853Z",
            id: "573776f8c3a36805ab001040",
            updated_at: "2021-06-23T15:57:47.688Z",
            url: "https://www.themoviedb.org/review/573776f8c3a36805ab001040"
        },
        {
            author: "Wuchak",
            author_details: {
                name: "",
                username: "Wuchak",
                avatar_path: "/4KVM1VkqmXLOuwj1jjaSdxbvBDk.jpg",
                rating: 4.0
            },
            content: "The cuss-oriented squabbles of lowlife crooks for 99 minutes (and no women)\r\n\t\r\nRELEASED IN 1992 and written/directed by Quentin Tarantino, \"Reservoir Dogs” is a crime drama/thriller about a diamond heist gone disastrously wrong in Los Angeles wherein the surviving thugs bicker back-and-forth in a warehouse about which of their members is a police informant. The main thieves are played by Harvey Keitel, Tim Roth, Steve Buscemi, Michael Madsen and Chris Penn while Lawrence Tierney appears as the old salt mastermind.\r\n\r\nThis was Tarantino’s first feature film, costing only $1,200,000, and it has quirky glimmerings of future greatness, as seen in “Pulp Fiction” (1994), “Jackie Brown” (1997), “Kill Bill” (2003/2004), “Inglourious Basterds” (2009) and “Django Unchained” (2012), but “Reservoir” didn’t work for me. It’s hampered by a low-budget vibe, which I can handle, but not the uninteresting lowlife characters, their self-made conundrum, their interminably dull dialogue and the one-dimensional setting where about 80% of the story takes place in an old warehouse, not to mention no females in the main cast.\r\n\r\nStill, it’s interesting to observe Tarantino’s first serious stab at filmmaking and it has its moments of genuine entertainment. It’s a lesson on humble beginnings, which shows potential while not being up to snuff.\r\n\r\nTHE FILM RUNS 1 hour, 39 minutes and was shot in Los Angeles & Burbank.\r\n\r\nGRADE: C-",
            created_at: "2018-06-04T17:12:13.041Z",
            id: "5b1572ed0e0a262dd600b601",
            updated_at: "2021-06-23T15:58:09.282Z",
            url: "https://www.themoviedb.org/review/5b1572ed0e0a262dd600b601"
        }
    ],
    total_pages: 1,
    total_results: 2
}

end

def test_movie_review_info
  @movie_review_info_data = [
        {
            author: "talisencrw",
            author_details: {
                name: "",
                username: "talisencrw",
                avatar_path: "/https://secure.gravatar.com/avatar/cbcc9350415274a3c68399bd37ca3ebc.jpg",
                rating: 10.0
            },
            content: "This unique take on the heist-film-gone-wrong was excellent--stylish and intelligently made, yet very funny and inexpensive. Tarantino's accolades from giving American cinema the resuscitation it needed mirrors what has happened, at least since the 70's, with Martin Scorsese's 'Mean Streets', both in terms of entertaining violence and usage of music in the scoring of films. I greatly thank Harvey Keitel for taking a chance on Tarantino back then--It paid off in spades.",
            created_at: "2016-05-14T19:05:28.853Z",
            id: "573776f8c3a36805ab001040",
            updated_at: "2021-06-23T15:57:47.688Z",
            url: "https://www.themoviedb.org/review/573776f8c3a36805ab001040"
        },
        {
            author: "Wuchak",
            author_details: {
                name: "",
                username: "Wuchak",
                avatar_path: "/4KVM1VkqmXLOuwj1jjaSdxbvBDk.jpg",
                rating: 4.0
            },
            content: "The cuss-oriented squabbles of lowlife crooks for 99 minutes (and no women)\r\n\t\r\nRELEASED IN 1992 and written/directed by Quentin Tarantino, \"Reservoir Dogs” is a crime drama/thriller about a diamond heist gone disastrously wrong in Los Angeles wherein the surviving thugs bicker back-and-forth in a warehouse about which of their members is a police informant. The main thieves are played by Harvey Keitel, Tim Roth, Steve Buscemi, Michael Madsen and Chris Penn while Lawrence Tierney appears as the old salt mastermind.\r\n\r\nThis was Tarantino’s first feature film, costing only $1,200,000, and it has quirky glimmerings of future greatness, as seen in “Pulp Fiction” (1994), “Jackie Brown” (1997), “Kill Bill” (2003/2004), “Inglourious Basterds” (2009) and “Django Unchained” (2012), but “Reservoir” didn’t work for me. It’s hampered by a low-budget vibe, which I can handle, but not the uninteresting lowlife characters, their self-made conundrum, their interminably dull dialogue and the one-dimensional setting where about 80% of the story takes place in an old warehouse, not to mention no females in the main cast.\r\n\r\nStill, it’s interesting to observe Tarantino’s first serious stab at filmmaking and it has its moments of genuine entertainment. It’s a lesson on humble beginnings, which shows potential while not being up to snuff.\r\n\r\nTHE FILM RUNS 1 hour, 39 minutes and was shot in Los Angeles & Burbank.\r\n\r\nGRADE: C-",
            created_at: "2018-06-04T17:12:13.041Z",
            id: "5b1572ed0e0a262dd600b601",
            updated_at: "2021-06-23T15:58:09.282Z",
            url: "https://www.themoviedb.org/review/5b1572ed0e0a262dd600b601"
        }
    ]
end

