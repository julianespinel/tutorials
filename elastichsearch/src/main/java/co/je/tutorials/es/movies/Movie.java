package co.je.tutorials.es.movies;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Created by julian on 29/05/17.
 */
public class Movie implements  Comparable<Movie> {
    private final String id;
    private final String title;
    private final String summary;
    private final String director;
    private final int releaseYear;

    @JsonCreator
    public Movie(@JsonProperty("id") String id, @JsonProperty("title") String title,
                 @JsonProperty("summary") String summary, @JsonProperty("director") String director,
                 @JsonProperty("releaseYear") int releaseYear) {
        this.id = id;
        this.title = title;
        this.summary = summary;
        this.director = director;
        this.releaseYear = releaseYear;
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getSummary() {
        return summary;
    }

    public String getDirector() {
        return director;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    @Override
    public int compareTo(Movie movie) {
        int sameId = id.compareToIgnoreCase(movie.getId());
        int sameTitle = title.compareToIgnoreCase(movie.getTitle());
        int sameSummary = summary.compareToIgnoreCase(movie.getSummary());
        int sameDirector = director.compareToIgnoreCase(movie.getDirector());
        int sameYear = releaseYear - movie.getReleaseYear();
        return (sameId + sameTitle + sameSummary + sameDirector + sameYear);
    }
}
