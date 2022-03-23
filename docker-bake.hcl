// GITHUB_REF is the actual ref that triggers the workflow
// https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
variable "GITHUB_REF" {
  default = ""
}

target "_common" {
  args = {
    GIT_REF = GITHUB_REF
  }
}

group "default" {
  targets = ["image-local"]
}

// Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {
  tags = ["syft:local"]
}

target "binary" {
  inherits = ["_common"]
  target = "binary"
  output = ["./bin"]
}

target "artifact" {
  inherits = ["_common"]
  target = "artifact"
  output = ["./bin"]
}

target "artifact-all" {
  inherits = ["artifact"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}

target "image" {
  inherits = ["_common", "docker-metadata-action"]
  labels = {
    "io.artifacthub.package.readme-url": "https://raw.githubusercontent.com/anchore/syft/main/README.md"
    "io.artifacthub.package.logo-url": "https://user-images.githubusercontent.com/5199289/136844524-1527b09f-c5cb-4aa9-be54-5aa92a6086c1.png"
    "io.artifacthub.package.license": "Apache-2.0"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
