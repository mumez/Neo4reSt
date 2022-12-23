# Neo4reSt
A REST client/object wrapper of Neo4j graph database for Pharo and Squeak

## Features

- Raw rest client
- Wrapper client which handles JSON well
- Object level wrapper classes (Node, Relationship, Property)


## Installation

```smalltalk
Metacello new
  baseline: 'Neo4reSt';
  repository: 'github://mumez/Neo4reSt/repository';
  load.
```

## Note on tests

Before running test cases in 'Neo4reSt-Tests', you need to configure `N4GraphDbTest class>>defaultSettings` according to your Neo4j environment. Please edit and evaluate `N4GraphDbTest class>>initSettingsExample`.

## Basic usages

In Neo4j web console:
```
:play movie-graph
```
This will open the instruction for populating sample Movie Graph data.

Then, in Smalltalk Playground (Workspace):

```smalltalk
db := N4GraphDb new.
db settings username: 'neo4j'; password: 'neoneo'.
db allLabels. "Get all node labels"

"Print 'Movie' node properties"
(db nodesLabeled: 'Movie') 
   do: [ :each | Transcript cr; show: each properties ].
```

## Get node with where:

```smalltalk
matrix := (db nodesLabeled: 'Movie' where: [:each | each @ 'title' = 'The Matrix']) first.
matrix properties.
```

## Get relationships

```smalltalk
matrix inRelationships.
matrix outRelationships.

(matrix inRelationshipsTyped: 'ACTED_IN')
  collect: [:each | each tailNode @ 'name']. 
```

## Get relationships with where:

```smalltalk
(matrix inRelationshipsTyped: 'ACTED_IN' where: [ :start :rel :end | (rel @ 'roles') = #('Neo') ])
  collect: [ :each | each tailNode properties ].
```

## Create nodes

```smalltalk
sf := db mergeNodeLabeled: 'Genre' properties: {'name'->'SF'. 'description'->'Science Fiction'}.
action := db mergeNodeLabeled: 'Genre' properties: {'name'->'Action'. 'description'->'Exciting Actions'}. 
```

## Create relationships

```smalltalk
matrixToSf := matrix relateOneTo: sf typed: 'HAS_GENRE' properties: {'score'-> 6}.
matrixToAction := matrix relateTo: action typed: 'HAS_GENRE' properties: {'score'-> 7}. 
```

## Execute Cypher directly

```smalltalk
db runCypher: 'UNWIND range(1, 10) AS n RETURN n*n'. "inspect it"

resp := db runCypher: 'UNWIND range($from, $to) AS n RETURN n*n' 
         arguments: {'from'->2. 'to'->5}. 
resp values. "print it"
```

## Execute dynamically generated Cypher

```smalltalk
m := 'm' asCypherIdentifier. "Movie"
p := 'p' asCypherIdentifier. "Person"
o := 'o' asCypherIdentifier. "Other person"

pathPattern := (p node: 'Person') - ('act1' asCypherIdentifier rel: 'ACTED_IN' ) -> (m node: 'Movie' props: {'released'->2000})  <- ('act2' asCypherIdentifier rel: 'ACTED_IN' ) - (o node: 'Person').

actorNameParam := 'actorName' asCypherParameter.
where := (p @ 'name') starts: actorNameParam.
"where := ((p @ 'born') > 1970) and: ((o @ 'born') > 1970). " " <= try changing"

return := (p @ 'name'), (o @ 'name'), (m @ 'title').

query := CyQuery match: pathPattern where: where return: return orderBy: (p @ 'name') skip: 0 limit: 100. "print it"

result := db runCypher: query arguments: { actorNameParam -> 'Tom' }.
(result values groupedBy: [ :each | each at: 1 ]). "inspect it"
```

## Changing IP and port

```smalltalk
db settings rootUri: 'bolt://127.0.0.1:7687'.
```

## Other Documents

- [Interacting with Neo4j from Pharo Smalltalk](https://hashnode.com/post/interacting-with-neo4j-from-pharo-smalltalk-ckltglsqq085o10s14bkhfhke)
  - Actually, it is the introduction of SCypherGraph, another Neo4j client using FFI. However, the API is almost the same.

- [Introducing Neo4reSt](https://drive.google.com/file/d/0B-QQfEn6pNsXTzF3UnBZWHA3ZW8/view?usp=sharing)
  - A short presentation on Smalltalkers meeting in Tokyo 2011 December (OLD API)
