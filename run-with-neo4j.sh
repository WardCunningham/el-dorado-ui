docker run -d --rm --name el-dorado-ui -e GRAPHDBURL="http://neo4j:neo4j1234@host.docker.internal:7474/" -p 9292:9292 el-dorado-ui $*
