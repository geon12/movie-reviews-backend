require 'csv'

puts "Start seeding"
MovieReview.destroy_all
Movie.destroy_all
Reviewer.destroy_all


movie_data= CSV.read("../IMDb_movies.csv")
movie_data = movie_data.filter {|movie| movie[7] == 'USA' && movie[3].to_i >= 1970}
movie_data = movie_data.sample(250)


movie_data  = movie_data.map {|movie| [movie[1],movie[3].to_i, movie[6].to_i,movie[9],movie[13]]}

movie_data.each {|movie| Movie.create(name:movie[0], year:movie[1], duration:movie[2], director:movie[3],description:movie[4])}

outlets = ["Washington Post", "New York Times", "Baltimore Sun","AV Club","Film Reviews", "Independent", "The Guardian",
        "The Sun", "Film Review","Chicago Sun-Times","The Chronicle","Movie Reviews","Austin Review","Movie Blog",
        "Movies Today", "Hollywood Reporter","Film Buddies", "Popcorn Reviews","Atlanta Journal","Entertainment Weekly", "The New Yorker",
        "Huffington Post", "BBC", "Los Angeles TImes","Time","New York Post", "Slate","Dallas News", "USA Today","BuzzFeed",
        "Miami Times","Chicago Tribune","Houston Chronicle","Boston Globe","Philly Inquirer","E!","Movies Monthly","Vice"]

80.times do 
    Reviewer.create(name: Faker::Name.name,outlet: outlets.sample)
end

Reviewer.all.each do |reviewer|
    movies = Movie.all.sample(rand(30..50)) 
    movies.each {|movie| MovieReview.create(reviewer:reviewer,movie:movie,likes:rand(0..50),rating:rand(1..10), review:Faker::Lorem.paragraph(sentence_count: 3))}
end

puts "Done seeding"