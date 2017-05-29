package co.je.tutorials.es.movies;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.*;

/**
 * Created by julian on 29/05/17.
 */
public class MovieControllerTest {

    private MoviePersistence persistence;
    private MovieController controller;

    @Before
    public void setUp() throws Exception {
        persistence = mock(MoviePersistence.class);
        controller = new MovieController(persistence);
    }

    @After
    public void tearDown() throws Exception {
        controller = null;
        persistence = null;
    }

    @Test
    public void add() throws Exception {
        Movie movie = MovieFactory.getTestingMovie();
        controller.add(movie);
        verify(persistence).add(movie);
    }

    @Test
    public void get() throws Exception {
        Movie movie = MovieFactory.getTestingMovie();
        String id = movie.getId();
        when(persistence.get(id)).thenReturn(movie);
        Movie expectedMovie = controller.get(id);
        verify(persistence).get(id);
        assertEquals(0, movie.compareTo(expectedMovie));

    }

    @Test
    public void update() throws Exception {
        Movie movie = MovieFactory.getTestingMovie();
        String id = movie.getId();
        Movie modifiedMovie = MovieFactory.getModifiedMovie();
        controller.update(id, modifiedMovie);
        verify(persistence).update(id, modifiedMovie);
    }

    @Test
    public void delete() throws Exception {
        Movie movie = MovieFactory.getTestingMovie();
        String id = movie.getId();
        controller.delete(id);
        verify(persistence).delete(id);
    }
}