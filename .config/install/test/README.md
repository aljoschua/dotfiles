# Test install system

Here, I want to setup a little docker container in which I can test my changes
to the `install.sh` file.  The `Dockerfile` defines a docker image which
includes handy shell aliases as well as automatically authenticating to sudo on
startup. The `docker-compose.yml` file is a shortcut so I don't have to specify
a volume and `-i` to `docker run`.


## How to test
```bash
path/to/run.sh
# For example:
test/run.sh
```

Before running the test, you need to supply a build argument for the docker image. This avoids the prompt for the github personal access token (So you can clone private repositories). Use `docker-compose build --build-arg github_pat={...}` for that.
The `docker-compose build` command only needs to be rerun if there are changes to the `Dockerfile`.
