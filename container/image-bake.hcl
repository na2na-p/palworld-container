group "default" {
    targets = ["app"]
}

target "app" {
    dockerfile = "container/Dockerfile"
    platforms = ["linux/amd64", "linux/arm64"]
    cache-to = ["type=local,dest=/tmp/.buildx-cache"]
    cache-from = ["type=local,src=/tmp/.buildx-cache"]
}
