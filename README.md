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

## Documents

A short presentation on Smalltalkers meeting in Tokyo 2011 December.
- [Introducing Neo4reSt](https://drive.google.com/file/d/0B-QQfEn6pNsXTzF3UnBZWHA3ZW8/view?usp=sharing)

## Note

Since Neo4j 2.x, REST API requires authentication. So, you should set `N4Settings>>useAuthentication` to true, and set username/password by `N4Settings>>username` & `N4Settings>>password`.

Starting with Neo4j 4.x, the REST API has been replaced by the new HTTP transaction API. You can still use Cypher queries by setting `N4Settings>>supportV4` to `true`.
