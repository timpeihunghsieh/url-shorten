package com.url_shorten_app.url_shorten;

import com.google.inject.AbstractModule;

public class UrlShortenModule extends AbstractModule {
  @Override
  protected void configure() {
    bind(UrlStorage.class).to(UrlStorageImpl.class);
  }
}