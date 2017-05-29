package co.je.tutorials.es.movies;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.Strings;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Objects;
import java.util.concurrent.ExecutionException;

import static org.junit.Assert.*;

/**
 * Created by julian on 29/05/17.
 */
public class MoviePersistenceTest {

    private static final int OK = 200;
    private static final int CREATED = 201;

    private ObjectMapper objectMapper;
    private TransportClient esClient;
    private MoviePersistence persistence;

    private static TransportClient initializeESClient() throws UnknownHostException {
        TransportClient esClient = new PreBuiltTransportClient(Settings.EMPTY)
            .addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName("localhost"), 9300));
        return esClient;
    }

    @Before
    public void setUp() throws Exception {
        objectMapper = new ObjectMapper();
        esClient = initializeESClient();
        persistence = new MoviePersistence(objectMapper, esClient);
    }

    @After
    public void tearDown() throws Exception {
        persistence = null;
        esClient = null;
        objectMapper = null;
    }

    @Test
    public void add_OneMovie_StatusCreated() throws Exception {
        Movie movie = MovieFactory.getTestingMovie();
        String createdId = persistence.add(movie);
        assertFalse(Strings.isNullOrEmpty(createdId));
    }

    @Test
    public void get_OneMovie_ReturnsExpectedMovie() throws Exception {
        Movie expectedMovie = MovieFactory.getTestingMovie();
        String createdId = persistence.add(expectedMovie);
        assertFalse(Strings.isNullOrEmpty(createdId));
        Movie movie = persistence.get(createdId);
        assertNotNull(movie);
        assertEquals(0, expectedMovie.compareTo(movie));
    }

    @Test
    public void get_OneMovie_ThrowsIOException() throws Exception {
        try {
            Movie expectedMovie = MovieFactory.getTestingMovie();
            persistence.get(expectedMovie.getId());
            fail("Should throw an exception");
        } catch (MovieNotFoundException e) {
            assertNotNull(e);
        }
    }

    @Test
    public void update_OneMovie_OriginalMovieDifferentToUpdatedMovie() throws Exception {
        Movie movie = MovieFactory.getTestingMovie();
        String createdId = persistence.add(movie);
        assertFalse(Strings.isNullOrEmpty(createdId));
        Movie updatedMovie = MovieFactory.getModifiedMovie();
        assertNotEquals(0, movie.compareTo(updatedMovie));
        persistence.update(createdId, updatedMovie);
        Movie retrievedMovie = persistence.get(createdId);
        assertEquals(0, updatedMovie.compareTo(retrievedMovie));
    }

    @Test
    public void update_OneMovie_MovieNotFoundAndThrowsException() throws Exception {
        try {
            String fakeMovieId = "123";
            Movie updatedMovie = MovieFactory.getModifiedMovie();
            persistence.update(fakeMovieId, updatedMovie);
            fail("Method should throw an exception because the movie with the given ID does not exist.");
        } catch (JsonProcessingException | ExecutionException | InterruptedException e) {
            assertNotNull(e);
        }
    }

    @Test
    public void delete_OneExistingMovie_DeleteOK() throws Exception {
        try {
            Movie movie = MovieFactory.getTestingMovie();
            String createdId = persistence.add(movie);
            assertFalse(Strings.isNullOrEmpty(createdId));
            persistence.delete(createdId);
            persistence.get(createdId);
            fail("Method should throw an exception because the movie does not exist.");
        } catch (MovieNotFoundException e) {
            assertNotNull(e);
        }
    }

    @Test
    public void delete_OneNonExistingMovie_DoesNotThrowException() throws Exception {
        try {
            String fakeMovieId = "123";
            persistence.delete(fakeMovieId);
        } catch (Exception e) {
            fail("Method should not throw an exception even if the movie with the given ID does not exist.");
        }
    }
}