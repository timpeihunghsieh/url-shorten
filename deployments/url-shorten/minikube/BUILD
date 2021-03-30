package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")
load("@local_k8//:defaults.bzl", "local_k8")

# Redis Master
local_k8(
    name = "redis-master-service",
    template = "//deployments/url-shorten/redis-master:service.yaml",
)

local_k8(
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

# Redis Slave
local_k8(
    name = "redis-slave-service",
    template = "//deployments/url-shorten/redis-slave:service.yaml",
)

local_k8(
    name = "redis-slave-deployment",
    template = "//deployments/url-shorten/redis-slave:deployment.yaml",
)

k8s_objects(
    name = "redis-slave",
    objects = [
        ":redis-slave-service",
        ":redis-slave-deployment",
    ],
)

# url-shorten

local_k8(
    name = "url-shorten-service",
    template = "//deployments/url-shorten/url-shorten:service.yaml",
)

local_k8(
    name = "url-shorten-deployment-production",
    images = {
        "url-shorten-production:latest": "//java/com/url-shorten-app/url-shorten:url-shorten-server-img",
    },
    template = "//deployments/url-shorten/url-shorten:deployment-production.yaml",
)

local_k8(
    name = "url-shorten-deployment-canary",
    images = {
        "url-shorten-canary:latest": "//java/com/url-shorten-app/url-shorten:url-shorten-server-img",
    },
    template = "//deployments/url-shorten/url-shorten:deployment-canary.yaml",
)

k8s_objects(
    name = "url-shorten",
    objects = [
        ":url-shorten-service",
        ":url-shorten-deployment-production",
        ":url-shorten-deployment-canary",
    ],
)

# Main k8s objects

k8s_objects(
    name = "k8-all",
    objects = [
        ":redis-slave",
        ":redis-master",
        ":url-shorten",
    ],
)
