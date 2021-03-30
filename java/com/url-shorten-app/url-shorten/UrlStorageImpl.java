package com.url_shorten_app.url_shorten;

import com.google.inject.Inject;
import redis.clients.jedis.Jedis;

public class UrlStorageImpl implements UrlStorage {
  private Jedis redis;

  @Inject
  public UrlStorageImpl() {
    this.redis = new Jedis("redis-master");
  }

  @Override
  public boolean addUrlMapping(String shortUrl, String longUrl) {
    this.redis.set(shortUrl, longUrl);
    return true;
  }

  @Override
  public String getLongUrl(String shortUrl) {
    return this.redis.get(shortUrl);
  }
}
