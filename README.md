# paradise4j

## Components implemented:

### ETL script for Graph database (peristence) - neo4j
- The repo contains the ETL script that helps tp load the data to neo4j graph database for `Offshore Leaks is graph data, which is constituted of nodes of various types and links (edges) between the nodes.` from https://offshoreleaks-data.icij.org/offshoreleaks/csv/csv_paradise_papers.2018-02-14.zip

Steps to execute:

Please download neo4j from the following link https://neo4j.com/download-thanks/?edition=community&release=3.5.5

1. tar -xf neo4j-community-3.5.5-unix.tar.gz
2. SET env variable NEO4J_HOME
3. cd $NEO4J_HOME
4. Clone this repo to your local machine
4. Copy the script from this repo's `neo4j-etl\paradise_etl.sh` to <NEO4J_HOME>
5. Start neo4j `./bin/neo4j start` 
6. Then run the script `./paradise_etl.sh`

The Paradise paper data should get loaded in the graph db and ready to serve.


### Middleware GraphQL (API) - Apollo

Steps to execute:

Please install node/npm (prerequesite)

1. cd `graphql-api-server`
2. `npm install`
3. `npm start`
