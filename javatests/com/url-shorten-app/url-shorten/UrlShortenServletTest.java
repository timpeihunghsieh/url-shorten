package com.url_shorten_app.url_shorten;

import static org.junit.Assert.assertTrue;

import java.io.IOException;
import javax.servlet.ServletException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

@RunWith(MockitoJUnitRunner.class)
public class UrlShortenServletTest {
  private UrlShortenServlet servlet;
  private MockHttpServletRequest request;
  private MockHttpServletResponse response;

  private final String SHORT_URL_PARAM = "short_url";
  private final String LONG_URL_PARAM = "long_url";
  private final String REDIR_PARAM = "r";
  private final String VALID_SHORT_URL = "abc";
  private final String VALID_LONG_URL = "http://www.cnn.com";

  @Mock
  private UrlStorage urlStorage;

  @Before
  public void setUp() {
    servlet = new UrlShortenServlet(urlStorage);
    request = new MockHttpServletRequest();
    response = new MockHttpServletResponse();
  }

  @Test
  public void testEmptyRequest()
      throws ServletException, IOException {
    servlet.doGet(request, response);
    assertTrue("Response does not contain Usage",
        response.getContentAsString().contains("Usage:"));
  }

  @Test
  public void testValidInsertRequest()
      throws ServletException, IOException {
    Mockito.when(urlStorage.addUrlMapping(VALID_SHORT_URL, VALID_LONG_URL))
        .thenReturn(true);
    request.addParameter(SHORT_URL_PARAM, VALID_SHORT_URL);
    request.addParameter(LONG_URL_PARAM, VALID_LONG_URL);

    servlet.doGet(request, response);

    assertTrue("Response does not contain short URL",
        response.getContentAsString().contains(VALID_SHORT_URL));
  }

  @Test
  public void testValidRedir()
      throws ServletException, IOException {
    Mockito.when(urlStorage.getLongUrl(VALID_SHORT_URL))
        .thenReturn(VALID_LONG_URL);
    request.addParameter(REDIR_PARAM, VALID_SHORT_URL);

    servlet.doGet(request, response);

    assertTrue("Response does not contain long URL",
        response.getRedirectedUrl().contains("cnn"));
  }
}