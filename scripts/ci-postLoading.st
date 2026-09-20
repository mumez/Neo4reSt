"Configure Neo4j connection settings for CI (neo4j:community on port 7474)."
N4GraphDbTest defaultSettings
  username: 'neo4j';
  password: 'testpass';
  rootUri: 'http://localhost:7474/';
  supportV4: true;
  useAuthentication: true.
