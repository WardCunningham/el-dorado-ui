# El Dorado UI

This is a Sinatra app that provides a UI and canned queries for El Dorado, an enterprise structure warehouse.
The web user can retreive results from a menu of queries or author new ad-hoc queries interactively.
Results are in the form of tables or diagrams both of which can hyperlink to related queries.

Queries are written in Neo4j's Cypher language. Tabular results are then optionally rendered by template expansion into Graphviz's Dot language and displayed as SVG. Modeling conventions support tracing relations to their ETL source, but the graph database is not otherwise restricted.

![system diagram](images/system-diagram.png?raw=true)

Learn more about this project at http://ddd.ward.wiki.org/

## Running Locally

To get this app running locally:

~~~
gem install bundler
bundle install
bundle exec rackup
~~~

You can then visit the app at http://localhost:9292

We assume the `dot` command is available from [Graphviz](http://www.graphviz.org/).

If you are not running your own instance of Neo4J locally, you'll need to alter
the database connection string with the GRAPHDBURL environment variable.

~~~
GRAPHDBURL='http://neo4j:neo4j@example.com:7474/' bundler exec rackup -o '0.0.0.0'
~~~


## Docker version
Use `Dockerfile` and `build-docker-image.sh` to build a docker image.  The `run-with-neo4j.sh` runs it with a connection to a local neo4j instance.

To run a local neo4j database, you can use docker:
```
docker run --name neo4j --rm -d --publish=7474:7474 --publish=7687:7687 -e NEO4J_AUTH=neo4j/neo4j1234 --volume=$HOME/neo4j/data:/data neo4j
```

We have upgraded to ruby 2.7.2 and latest neo4j-core, which required some changes in `el_dorado.rb` to use the `GRAPHDBURL` environment variable value via `Neo4j::Core::CypherSession` rather than `Neo4j::Session.open()`.   Future options could be to use other protocls (like bolt) - see https://github.com/neo4jrb/neo4j-core/tree/9.0.x

## Tracking Sources
When launching El Dorado for the first time it is convenient to examine familiar databases such as those built into the Neo4j web interface. Use the `Schema with Sources` canned query to see your data. By convention we attach a source property to every relation. See this work by adding a source to the sample movie data with this query:
```
match (p:Person)-[r]-(m:Movie)
set r.source = 'movies'
return r
```
This shows up with dotted lines to relations labeled with a count.

![image](https://user-images.githubusercontent.com/12127/97227422-b1c3df00-1792-11eb-8ff4-1d26a97631ba.png)

Click the counts to see a good sampling of these relations.

## License

Copyright [2017] New Relic, Inc.  Licensed under the Apache License, version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at [apache.org](http://www.apache.org/licenses/LICENSE-2.0). Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, either express or implied.
