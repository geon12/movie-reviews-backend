class Application

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)

    content_type = { 'Content-Type' => 'application/json' }

    if req.path == "/movies" && req.get?
      movies = Movie.all
      return [
        200, 
        content_type, 
        [movies.as_json(methods: :average_rating).to_json]
        #[ movies.to_json ]
      ]

    elsif req.path.match('/movies/') && req.post?
      body = JSON.parse(req.body.read)
      movie = Movie.create(body)
      return [
        200, 
        content_type, 
        [ movie.to_json ]
      ]

    elsif req.path.match('/movies/') && req.get?
      id = req.path.split('/')[2]
      begin
        movie = Movie.find(id)
        return [200, content_type, [movie.as_json(include: :movie_reviews).to_json] ]
      rescue
        return [404, content_type, [{message: "Movie not found"}.to_json]]
      end

    elsif req.path.match('/movies/') && req.patch?
      id = req.path.split('/')[2]
      body = JSON.parse(req.body.read)
      begin
        movie = Movie.find(id)
        movie.update(body)
        return [202, content_type, [movie.to_json]]
      rescue
        return [404, content_type, [{message: "Movie not found"}.to_json]]
      end
    

    elsif req.path == '/reviewers' && req.get?
      reviewers = Reviewer.all
      return [
        200,
        content_type,
        [reviewers.as_json(methods: :total_likes).to_json]
        #[reviewers.to_json]
      ]

    elsif req.path.match('/reviewers') && req.post?
      body = JSON.parse(req.body.read)
      reviewer = Reviewer.create(body)
      return [
        200, 
        content_type, 
        [reviewer.to_json ]
      ]
    elsif req.path.match('/reviewers/') && req.get?
      id = req.path.split('/')[2]
      begin
        reviewer = Reviewer.find(id)
        return [200, content_type, [reviewer.as_json(include: :movie_reviews).to_json] ]
      rescue
        return [404, content_type, [{message: "Reviewer not found"}.to_json]]
      end

    elsif req.path.match('/reviewers/') && req.patch?
      id = req.path.split('/')[2]
      body = JSON.parse(req.body.read)
      begin
        reviewer = Reviewer.find(id)
        reviewer.update(body)
        return [202, content_type, [reviewer.to_json]]
      rescue
        return [404, content_type, [{message: "Reviewer not found"}.to_json]]
      end
    


    elsif req.path == '/movie_reviews' && req.get?
      movie_reviews = MovieReview.all
      return [200, content_type, [movie_reviews.to_json]]

    elsif req.path.match('/movie_reviews') && req.post?
      body = JSON.parse(req.body.read)
      movie_review = MovieReview.create(body)
      return [
        200, 
        content_type, 
        [ movie_review.to_json ]
      ]

    elsif req.path.match('/movie_reviews/') && req.get?
      id = req.path.split('/')[2]
      begin
        movie_review = MovieReview.find(id)
        return [200, content_type, [movie_review.as_json(include: [:movie,:reviewer]).to_json] ]
      rescue
        return [404, content_type, [{message: "Movie Review not found"}.to_json]]
      end
    
    elsif req.path.match('/movie_reviews/') && req.patch?
      id = req.path.split('/')[2]
      body = JSON.parse(req.body.read)
      begin
        movie_review = MovieReview.find(id)
        movie_review.update(body)
        return [202, content_type, [movie_review.to_json]]
      rescue
        return [404, content_type, [{message: "Movie Review not found"}.to_json]]
      end

    
    elsif req.path.match('/movie_reviews/') && req.delete?
      id = req.path.split('/')[2]
      begin
        movie_review = MovieReview.find(id)
        movie_review.destroy
        return [200, content_type, [{message: "Movie Review Destroyed"}.to_json] ]
      rescue
        return [404, content_type, [{message: "Movie Review not found"}.to_json]]
      end
    
    # elsif req.path.match('/movies?name=') && req.get?
    #   query = req.path.split('name=')[1]
    #   movie = Movie.find_by(name: query)
    #   if movie
    #     return  [
    #       200, 
    #       content_type, 
    #       [ movie.to_json ]
    #     ]
    #   else
    #     return [404, content_type, [{message: "Movie not found"}.to_json]]
    #   end

    else
      return [404, content_type, [ {:message => "Path not Found"}.to_json ]]

    end

    res.finish
  end

end
