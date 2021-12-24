#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# https://github.com/sstephenson/bats

@test "goreleaser" {
  stub buildkite-agent "annotate : echo $ver"
  stub docker "run : echo $ver"

  export BUILDKITE_PLUGIN_GORELEASER_PROVIDERS_0="aws"
  export BUILDKITE_PLUGIN_GORELEASER_PROVIDERS_1="github"
  export BUILDKITE_PLUGIN_GORELEASER_TMPDIR="/tmp"

  run "$PWD/hooks/command"

  #assert_output --partial "$ver"
  assert_success

  unstub docker
  #unstub buildkite-agent
}