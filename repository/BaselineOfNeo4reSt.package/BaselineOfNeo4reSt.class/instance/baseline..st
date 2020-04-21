baseline
baseline: spec
	<baseline>

	spec for: #common do: [

		spec 
			package: 'Neo4reSt-Core';
			package: 'Neo4reSt-Client' with: [ spec requires: #('Neo4reSt-Core')];
			package: 'Neo4reSt-GraphModel' with: [ spec requires: #('Neo4reSt-Core' 'Neo4reSt-Client')];
			package: 'Neo4reSt-IndexModel' with: [ spec requires: #('Neo4reSt-Core' 'Neo4reSt-Client')];
			package: 'Neo4reSt-Traversal' with: [ spec requires: #('Neo4reSt-Core' 'Neo4reSt-Client')];
			package: 'Neo4reSt-Cypher' with: [ spec requires: #('Neo4reSt-Core' 'Neo4reSt-Client')];
			package: 'Neo4reSt-Demo-Dumper' with: [ spec requires: #('Neo4reSt-Core' 'Neo4reSt-Client')];
			package: 'Neo4reSt-Tests' with: [ spec requires: #('Neo4reSt-Core' 'Neo4reSt-Client')].
		spec
			group: 'default' with: #('Core' 'Tests');
			group: 'Core' with: #('Neo4reSt-Core' 'Neo4reSt-Client' 'Neo4reSt-GraphModel' 'Neo4reSt-IndexModel' 'Neo4reSt-Traversal' 'Neo4reSt-Cypher');
			group: 'Demo' with: #('Neo4reSt-Demo-Dumper');
			group: 'Tests' with: #('Neo4reSt-Tests')].
		
	spec for: #squeak do:[
		spec
			package: 'JSON' with: [
				spec
					repository: 'http://www.squeaksource.com/JSON'].
		spec
			package: 'WebClient-Core' with: [
				spec repository: 'http://www.squeaksource.com/WebClient' 
			].
		spec package: 'Neo4reSt-Squeak-Core' with: [spec requires: 'WebClient-Core'].
		spec group: 'Core' with: #('Neo4reSt-Squeak-Core').	
	].

	spec for: #pharo do:[
		spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
		spec package: 'Neo4reSt-Core' with: [spec includes: 'Neo4reSt-Pharo-Core'].
		spec package: 'Neo4reSt-Pharo-Core' with: [ spec requires: #('Neo4reSt-Core' 'NeoJSON')].
		spec group: 'Core' with: #('Neo4reSt-Pharo-Core').	
	].
