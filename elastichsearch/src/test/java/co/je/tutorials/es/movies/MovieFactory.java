package co.je.tutorials.es.movies;

/**
 * Created by julian on 29/05/17.
 */
public class MovieFactory {

    private static Movie modifiedMovie;

    public static Movie getTestingMovie() {
        String id = "id";
        String title = "Attack on Titan";
        String summary = "For over a century, people have been living behind barricades to block out the giant Titans that threaten to destroy the human race. When a Titan destroys his hometown, young Eren Yeager becomes determined to fight back.";
        String director = "";
        int releaseYear = 2013;
        Movie movie = new Movie(id, title, summary, director, releaseYear);
        return movie;
    }

    public static Movie getModifiedMovie() {
        String id = "id";
        String title = "Attack on Titan";
        String summary = "For over a century, people have been living behind barricades to block out the giant Titans that threaten to destroy the human race. When a Titan destroys his hometown, young Eren Yeager becomes determined to fight back.";
        String director = "Hajime Isayama";
        int releaseYear = 2017;
        Movie movie = new Movie(id, title, summary, director, releaseYear);
        return movie;
    }
}
