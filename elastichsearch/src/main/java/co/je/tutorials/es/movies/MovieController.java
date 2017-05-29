package co.je.tutorials.es.movies;

import com.fasterxml.jackson.core.JsonProcessingException;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

/**
 * Created by julian on 29/05/17.
 */
public class MovieController {

    private final MoviePersistence persistence;

    public MovieController(MoviePersistence persistence) {
        this.persistence = persistence;
    }

    public void add(Movie movie) throws JsonProcessingException {
        persistence.add(movie);
    }

    public Movie get(String movieId) throws IOException, MovieNotFoundException {
        return persistence.get(movieId);
    }

    public void update(String movieId, Movie movie) throws JsonProcessingException, ExecutionException, InterruptedException {
        persistence.update(movieId, movie);
    }

    public void delete(String movieId) {
        persistence.delete(movieId);
    }
}
