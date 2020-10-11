docker run -d --rm --name el-dorado-ui -e GRAPHDBURL="http://neo4j:neo4j1234@host.docker.internal:7687/" -p 9292:9292 el-dorado-ui bundle exec rackup -o "0.0.0.0"
