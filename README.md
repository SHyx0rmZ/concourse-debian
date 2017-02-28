# concourse-debian

This is a set of scripts to build Debian packages for Concourse. By default, four packages
are built: `concourse`, `concourse-bin`, `concourse-web` and `concourse-worker`.

`concourse-web` will automatically set up PostgreSQL and create a new database for Concourse.

After installation, you will be able to configure Concourse via files in `/etc/concourse`.
SSH keys will be stored in `/usr/lib/concourse`. Concourse's workspace will be located in
`/var/lib/concourse`. The binaries `concourse-web` and `concourse-worker` will be exposed.

This repository was created without prior knowledge in building Debian packages, so expect
a few quirks here and there.
