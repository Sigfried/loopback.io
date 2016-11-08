#!/bin/bash

# The following is a 3 column list of org, repo, and branch.
# The branch is optional and will default to 'master' if omitted.
(cat <<LIST_END
strongloop loopback-connector-cloudant
strongloop loopback-connector-dashdb
strongloop loopback-connector-db2
strongloop loopback-connector-db2iseries
strongloop loopback-connector-db2z
strongloop loopback-connector-informix
strongloop loopback-connector-jsonrpc
strongloop loopback-connector-kv-redis
strongloop loopback-connector-mongodb
strongloop loopback-connector-mqlight
strongloop loopback-connector-mssql
strongloop loopback-connector-mysql
strongloop loopback-connector-oracle
strongloop loopback-connector-postgresql
strongloop loopback-connector-redis
strongloop loopback-connector-remote
strongloop loopback-connector-rest
strongloop loopback-connector-soap
strongloop loopback-connector-sqlite3
strongloop loopback-android-getting-started master
strongloop loopback-example-angular master
strongloop loopback-example-app-logic master
strongloop loopback-example-access-control master
strongloop loopback-example-angular-live-set master
strongloop loopback-example-connector remote
strongloop loopback-example-connector rest
strongloop loopback-example-connector soap
strongloop loopback-example-database mssql
strongloop loopback-example-database mysql
strongloop loopback-example-database oracle
strongloop loopback-example-database postgresql
strongloop loopback-example-database master
strongloop loopback-example-kv-connectors master
strongloop loopback-example-middleware master
strongloop loopback-example-mixins master
strongloop loopback-example-offline-sync master
strongloop loopback-example-passport master
strongloop loopback-example-relations master
strongloop loopback-example-storage master
strongloop loopback-example-user-management master
strongloop loopback-example-isomorphic master
strongloop loopback-example-xamarin master
strongloop loopback-ios-getting-started master
strongloop strong-error-handler
strongloop strong-remoting
strongloop loopback-component-storage
strongloop loopback-component-explorer
strongloop loopback-component-push
strongloop loopback-component-passport
strongloop loopback-component-oauth2
LIST_END
) | while read org repo branch; do
  # Write the README.md to a file named after the repo
  DEST="pages/en/lb2/readmes/$repo.md"
  # When fetching from a branch of a gh repo
  GHURL="https://raw.githubusercontent.com/$org/$repo/$branch/README.md"
  # When fetching from the latest release of a node module
  NPMURL="https://registry.npmjs.org/$repo"
  if [ -z "$branch" ]; then
    # No branch means latest release, so fetch from npmjs.org
    echo "fetching $org/$repo from latest npmjs.org release..."
    curl -s $NPMURL | jq -r '.readme|rtrimstr("\n")' > $DEST
  else
    echo "fetching $org/$repo/$branch from GitHub's raw content domain..."
    curl -s $GHURL > $DEST
  fi
done
