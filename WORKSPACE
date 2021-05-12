workspace(name = "tim")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")

# Check out how external dependencies work.
# https://docs.bazel.build/versions/master/external.html

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_JVM_EXTERNAL_TAG = "2.8"
RULES_JVM_EXTERNAL_SHA = "79c9850690d7614ecdb72d68394f994fef7534b292c4867ce5e7dec0aa7bdfad"

http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    sha256 = RULES_JVM_EXTERNAL_SHA,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

################################# Maven #################################

maven_install(
    name = "main_mavin",
    artifacts = [
        "junit:junit:4.12",
        "androidx.test.espresso:espresso-core:3.1.1",
        "org.hamcrest:hamcrest-library:1.3",
        "org.eclipse.jetty:jetty-server:9.2.11.v20150529",
        "org.eclipse.jetty:jetty-servlet:9.2.11.v20150529",
        "org.eclipse.jetty:jetty-util:9.2.11.v20150529",
        "javax.servlet:javax.servlet-api:3.1.0",
        "com.google.inject:guice:4.2.2",
        "redis.clients:jedis:3.0.1",
        "io.prometheus:simpleclient:0.6.0",
        "io.prometheus:simpleclient_servlet:0.6.0",
        "junit:junit:4.12",
        "javax.servlet:javax.servlet-api:3.1.0",
        "org.mockito:mockito-all:1.10.19",
        "org.slf4j:slf4j-api:1.7.5",
        "org.slf4j:slf4j-simple:1.7.5",
        "org.springframework:spring-test:5.0.12.RELEASE",
        "org.nanohttpd:nanohttpd:2.3.1",
    ],
    repositories = [
        # Private repositories are supported through HTTP Basic auth
        # "http://username:password@localhost:8081/artifactory/my-repository",
        "https://maven.google.com",
        "https://repo1.maven.org/maven2",
    ],
)

################################# Docker #################################

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "1698624e878b0607052ae6131aa216d45ebb63871ec497f26c67455b34119c80",
    strip_prefix = "rules_docker-0.15.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.15.0/rules_docker-v0.15.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")
container_deps()

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)
container_pull(
  name = "java_base",
  registry = "gcr.io",
  repository = "distroless/java",
  # 'tag' is also supported, but digest is encouraged for reproducibility.
  digest = "sha256:deadbeef",
)

# Java Image
load(
    "@io_bazel_rules_docker//java:image.bzl",
    _java_image_repos = "repositories",
)

_java_image_repos()


################################# Kubernetes #############################

http_archive(
    name = "io_bazel_rules_k8s",
    strip_prefix = "rules_k8s-0.5",
    urls = ["https://github.com/bazelbuild/rules_k8s/archive/v0.5.tar.gz"],
    sha256 = "773aa45f2421a66c8aa651b8cecb8ea51db91799a405bd7b913d77052ac7261a",
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories")
k8s_repositories()

load("@io_bazel_rules_k8s//k8s:k8s_go_deps.bzl", k8s_go_deps = "deps")
k8s_go_deps()

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_defaults")

k8s_defaults(
    name = "local_k8",
    cluster = "minikube",
    image_chroot = "localhost:5000",
)

k8s_defaults(
    name = "simulation_k8",
    cluster = "gke_elevated-dynamo-310317_us-east1-b_simulation",
    image_chroot = "gcr.io/elevated-dynamo-310317",
)