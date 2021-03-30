package(default_visibility = ["//visibility:public"])

java_test(
    name = "UrlShortenServletTest",
    size = "small",
    srcs = ["UrlShortenServletTest.java"],
    test_class = "com.url_shorten_app.url_shorten.UrlShortenServletTest",
    deps = [
        "//java/com/url-shorten-app/url-shorten:url-shorten-lib",
        "@main_mavin//:junit_junit",
        "@main_mavin//:org_mockito_mockito_all",
        "@main_mavin//:org_slf4j_slf4j_api",
        "@main_mavin//:org_springframework_spring_test",
        "@main_mavin//:javax_servlet_javax_servlet_api",
    ],
)
