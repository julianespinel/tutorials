package co.je.tutorials.es.movies;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.elasticsearch.action.delete.DeleteResponse;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.update.UpdateRequest;
import org.elasticsearch.action.update.UpdateResponse;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.xcontent.XContentType;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

/**
 * Created by julian on 29/05/17.
 */
public class MoviePersistence {

    private static final String INDEX_NAME = "movies";
    private static final String INDEX_TYPE = "movie";

    private final ObjectMapper objectMapper;
    private final TransportClient esClient;

    public MoviePersistence(ObjectMapper objectMapper, TransportClient esClient) {
        this.objectMapper = objectMapper;
        this.esClient = esClient;
    }

    public String add(Movie movie) throws JsonProcessingException {
        String jsonMovie = objectMapper.writeValueAsString(movie);
        IndexResponse indexResponse = esClient.prepareIndex(INDEX_NAME, INDEX_TYPE).setSource(jsonMovie, XContentType.JSON).get();
        String cretedId = indexResponse.getId();
        return cretedId;
    }

    public Movie get(String movieId) throws IOException, MovieNotFoundException {
        GetResponse response = esClient.prepareGet(INDEX_NAME, INDEX_TYPE, movieId).get();
        if (response.isSourceEmpty()) {
            throw new MovieNotFoundException("The given movie ID is not into the DB.");
        }
        byte[] sourceAsBytes = response.getSourceAsBytes();
        Movie movie = objectMapper.readValue(sourceAsBytes, Movie.class);
        return movie;
    }

    public void update(String movieId, Movie movie) throws JsonProcessingException, ExecutionException, InterruptedException {
        UpdateRequest updateRequest = new UpdateRequest();
        updateRequest.index(INDEX_NAME);
        updateRequest.type(INDEX_TYPE);
        updateRequest.id(movieId);
        String jsonMovie = objectMapper.writeValueAsString(movie);
        updateRequest.doc(jsonMovie, XContentType.JSON);
        esClient.update(updateRequest).get();
    }

    public void delete(String movieId) {
        esClient.prepareDelete(INDEX_NAME, INDEX_TYPE, movieId).get();
    }
}
