package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")
load("@simulation_k8//:defaults.bzl", "simulation_k8")

# Redis Master
simulation_k8(
    name = "redis-master-service",
    template = "//deployments/url-shorten/redis-master:service.yaml",
)

simulation_k8(
    name = "redis-master-deployment",
    template = "//deployments/url-shorten/redis-master:deployment.yaml",
)

k8s_objects(
    name = "redis-master",
    objects = [
        ":redis-master-service",
        ":redis-master-deployment",
    ],
)

# url-shorten

simulation_k8(
    name = "url-shorten-service",
    template = "//deployments/url-shorten/url-shorten:service.yaml",
)

simulation_k8(
    name = "url-shorten-deployment-production",
    images = {
        "url-shorten-production:latest": "//java/com/url-shorten-app/url-shorten:url-shorten-server-img",
    },
    template = "//deployments/url-shorten/url-shorten:deployment-production.yaml",
)

simulation_k8(
    name = "url-shorten-service-monitor",
    template = "//deployments/url-shorten/url-shorten:service-monitor.yaml",
)

simulation_k8(
    name = "url-shorten-virtual-service",
    template = "//deployments/url-shorten/url-shorten:virtual-service.yaml",
)

k8s_objects(
    name = "url-shorten",
    objects = [
        ":url-shorten-service",
        ":url-shorten-service-monitor",
        ":url-shorten-virtual-service",
        ":url-shorten-deployment-production",
    ],
)

# Main k8s objects

k8s_objects(
    name = "k8-all",
    objects = [
        ":redis-master",
        ":url-shorten",
    ],
)
