package com.url_shorten_app.url_shorten;

import com.google.inject.Inject;
import io.prometheus.client.Counter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UrlShortenServlet extends HttpServlet {
  private UrlStorage urlStorage;

  static final Counter requests_total = Counter.build()
    .name("requests_total").help("Total Incoming requests.").register();
  static final Counter requests_redir = Counter.build()
    .name("requests_redir").help("Number of redirect requests.").register();
  static final Counter requests_insert = Counter.build()
    .name("requests_insert").help("Number of insertion requests.").register();
  static final Counter requests_default = Counter.build()
    .name("requests_default").help("Number of default or invalid requests.").register();

  @Inject
  public UrlShortenServlet(UrlStorage urlStorage) {
    super();
    this.urlStorage = urlStorage;
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    requests_total.inc();

    String redir = req.getParameter("r");
    String shortUrl = req.getParameter("short_url");
    String longUrl = req.getParameter("long_url");

    if (IsRedirctRequest(redir, shortUrl, longUrl)){
      RedirectUser(redir, resp);
    } else if (IsInsertRequest(redir, shortUrl, longUrl)) {
      InsertUrlAndReply(shortUrl, longUrl, resp);
    } else {
      ReplyWithUsage(resp);
    }
  }

  private boolean IsRedirctRequest(String redir, String shortUrl, String longUrl) {
    return (redir != null && !redir.isEmpty())
        && (shortUrl == null || shortUrl.isEmpty())
        && (longUrl == null || longUrl.isEmpty());
  }

  private boolean IsInsertRequest(String redir, String shortUrl, String longUrl) {
    return (redir == null || redir.isEmpty())
        && (shortUrl != null && !shortUrl.isEmpty())
        && (longUrl != null && !longUrl.isEmpty());
  }

  private void InsertUrlAndReply(String shortUrl, String longUrl, HttpServletResponse resp)
      throws IOException {
    urlStorage.addUrlMapping(shortUrl, longUrl);
    requests_insert.inc();

    String bodyText = shortUrl + " can now be used";
    resp.setStatus(200);
    resp.getWriter().println(bodyText);
  }

  private void ReplyWithUsage(HttpServletResponse resp)
      throws IOException {
    String bodyText = "Usage: short_url=[short]&long_url=[long] test change 8";
    resp.setStatus(200);
    resp.getWriter().println(bodyText);
    requests_default.inc();
  }

  private void RedirectUser(String redir, HttpServletResponse resp)
      throws IOException{
    String long_url = urlStorage.getLongUrl(redir);
    resp.sendRedirect(long_url);
    requests_redir.inc();
  }
}