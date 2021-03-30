package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//java:image.bzl", "java_image")

# url-shorten
java_library(
    name = "url-shorten-lib",
    srcs = [
        "UrlShortenModule.java",
        "UrlShortenServer.java",
        "UrlShortenServlet.java",
        "UrlStorage.java",
        "UrlStorageImpl.java",
    ],
    deps = [
        "@main_mavin//:org_eclipse_jetty_jetty_server",
        "@main_mavin//:org_eclipse_jetty_jetty_servlet",
        "@main_mavin//:org_eclipse_jetty_jetty_util",
        "@main_mavin//:javax_servlet_javax_servlet_api",
        "@main_mavin//:com_google_inject_guice",
        "@main_mavin//:redis_clients_jedis",
        "@main_mavin//:io_prometheus_simpleclient",
        "@main_mavin//:io_prometheus_simpleclient_servlet",
    ],
)
