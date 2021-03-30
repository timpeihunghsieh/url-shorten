package com.url_shorten_app.url_shorten;

public interface UrlStorage {
  public boolean addUrlMapping(String shortUrl, String longUrl);
  public String getLongUrl(String shortUrl);
}