# Viewing Party

This is the base repo for the [Viewing Party Lite project](https://backend.turing.edu/module3/projects/viewing_party_lite) used for Turing's Backend Module 3.

### About this Project

Viewing Party Lite is an application in which users can explore movie options and create a viewing party event for themselves and other users of the application.

## Setup

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:create`


## Versions
- Ruby 3.2.2
- Rails 7.0.6

## Testing
`bundle exec rspec` will run the entire test suite. All tests are passing at time of writin

The team tested happy paths, sad paths, and edge cases when needed. Error messages were added where applicable.

- To run model tests for this app, type the following command in your terminal:
    `bundle exec rspec spec/models`
- To run model tests for this app, type the following command in your terminal:
    `bundle exec rspec spec/features`
- This application uses the Simplecov gem to monitor test coverage.


## Project Status and Potential Next Steps
This project is completed as far as the requirements for this project. However a solo extension was added to include styling with css and html utilizing bootstrap.

Additional considerations for further extensions:
- adding photos and styling for movie show pages
- adding photos and styling for /movies search pages to have images in lieu of a list of names
- adding styling for mobile friendly design
- adding crud functionality to edit a viewing party or delete a viewing party as plans change


## Wireframes:
This application is deployed with Render. Here are some pictures of this application:
<details>
<summary>route: "/"</summary>

When visiting the root path "/" as a visitor (not logged in), the user will see the following:
![root page as a visiotr](<app/assets/images/root not logged in.png>)

If the user is logged in, they will also see a list of existing users on their root page.
![root page as a logged in user](<app/assets/images/logged in root page.png>)

</details>

<details>
<summary>route: "/register"</summary>


As a visitor, the user can click the button in the navigation bar to "create a new user". This will route them to the /register path where the user will fill out a form with their name, email and password (and password confirmation).
![register as a new user](<app/assets/images/register new user.png>)

All fields must be filled out in order for the new account to be created. A user will see validation error messages at the top of the screen if they do not completely fill out the form.
![validation errors for user when entire form is not filled out](<app/assets/images/validation errors creating new user.png>)

</details>

<details>
<summary>route: "/login"</summary>


As a visitor, the user can click the button in the navigation bar to "Log In". This will route them to the /login path where the user will fill out a form with their registered email and password
![login path user email and password](<app/assets/images/log in screen.png>)

</details>

<details>
<summary>route: "/discover"</summary>

As a visitor or a logged in user, the user can click the button in the navigation bar to "Discover Movies". This will route them to the /discover path where the user will see a button to discover top rated movies or to search movies by keyword input
![discover movies page with discover top rated movies or search by query buttons](<app/assets/images/logged in discover movies.png>)

</details>


<details>
<summary>route: "/movies"</summary>

As a visitor or a logged in user, after navigating to the /discover page, the user can click the button "Find Top Rated Movies". This will route the user to "/movies" where the user will see the top 20 movies. Each movie listed is a link to that movie's show page.
![find top rated movies](<app/assets/images/discover top movies.png>)

</details>

<details>
<summary>route: "/movies?query_params"</summary>

As a visitor or a logged in user, after navigating to the /discover page, the user can fill in a keyword in the form and click the "Find Movies" button. This will route the user to "/movies?#keyword=#{keyword_query}" where the user will see the 20 results of movie titles matching the inputted query word. Each movie listed is a link to that movie's show page.
![user searches query "spiderman" and gets top 20 results of movies matching that keyword](<app/assets/images/ spiderman discover results.png>)

</details>

<details>
<summary>route: "/movies/:movie_id"</summary>

As a visitor or a logged in user, after navigating to /movies or /movies?query, the user can click a link to that movies show page. They are then routed to "/movies/#{:movie_id}" path where the user can see details about that movie, including: title of the movie, that movies vote rating by users, runtime, genre categories, summary, top 10 cast members, and reviews left by users. The user also sees a button at the top of the page to "Create a Viewing Party for #{movie_title}".

![Movie show page for SpiderMan: Across the SpiderVerse](<app/assets/images/ spiderman discover results.png>)

</details>

<details>
<summary>route: "/movies/:movie_id/viewing_parties/new"</summary>

As a logged in user on a movie's show page, when they click the button to "Create a Viewing Party for #{movie_title}", it routes them to "/movies/:movie_id/viewing_parties/new" where they see a form to fill out the viewing party details of date, time and ability to invite other registered users to the viewing party. All fields of the form are required. The duration of the movie autopopulates with the selected movie's runtime but is adjustable by the user. The minimum duration of the party is the movie's runtime.
![viewing party date selection](<app/assets/images/spiderman VP date selection.png>)
![viewing party time selection](<app/assets/images/Spiderman VP time selection.png>)
![viewing party invite other registered users](<app/assets/images/Spiderman VP invite existing users.png>)


As a visitor on a movie's show page, if they click the button to "Create a Viewing Party for #{movie_title}", they receive an error that tells them they must be logged in order to create a viewing party.

</details>

<details>
<summary>route: "/dashboard"</summary>

As a logged in user on their dashboard page "/dashboard", the user can see all viewing parties they have been invited to or are hosting. Each movie listed has a link to that movie's show page, has the date and time of the viewing party, and whether they are "hosting" or "invited" to that viewing party.

![users dashboard](<app/assets/images/taylors dashboard.png>)

</details>

## Built with:
* [![Ruby][Ruby]][Ruby-url]
* [![Rails][Rails]][Rails-url]
* [![PostgreSQL][Postgres]][Postgres-url]
* [![UnSplash][UnSplash]][UnSplash-url]
* [![BootStrap][BootStrap]][Bootstrap-url]

## Contributors:
Base project:
* Ashley's Github Profile: [![Github][Github]][ashley-gh-url]
* Matthew's Github Profile: [![Github][Github]][matthew-gh-url]  

Solo Extension: adding styling and refactor
* Ashley's LinkedIn Profile: [![linkedin][linkedin]][ashley-url]
* Ashley's Github Profile: [![Github][Github]][ashley-gh-url]

<!-- LICENSE -->
## License
Distributed under the MIT License. See `LICENSE.txt` for more information.


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[ashley-url]: https://www.linkedin.com/in/ashley-plasket/
[Ruby]: https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[Ruby-url]: https://www.ruby-lang.org/en/
[BootStrap]: https://img.shields.io/badge/Bootstrap-%239400D3?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com/
[Rails]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org/
[Postgres]: https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white
[Postgres-url]: https://www.postgresql.org/
[UnSplash]: https://img.shields.io/badge/Unsplash-C0C0C0?style=for-the-badge&logo=unsplash&logoColor=white
[UnSplash-url]: https://unsplash.com/
[Render]: https://img.shields.io/badge/Render-1E90FF?style=for-the-badge&logo=render&logoColor=white
[Render-url]: https://render.com/
[Github]: https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white
[ashley-gh-url]: https://github.com/aplasket
[matthew-gh-url]: https://github.com/MWMJohnson