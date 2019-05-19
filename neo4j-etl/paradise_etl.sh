#!/bin/sh

#####Extract data from icij.org#####

wget https://offshoreleaks-data.icij.org/offshoreleaks/csv/csv_paradise_papers.2018-02-14.zip
# Extract to import directory.
tar -xzvf csv_paradise_papers.2018-02-14.zip -C import

#####Transform/prepare the data#####

# Nodes
for NODES_FILE in import/*.nodes.*.csv
do
    # Header
    LABEL_NAME=`echo $NODES_FILE | cut -d'.' -f 3`
    echo "$LABEL_NAME"
    head -n 1 $NODES_FILE |
        #sed "s/label/\:LABEL/" |
        sed "s/node_id/node_id\:ID/" |
        sed '1s/$/,\":LABEL"/' > $NODES_FILE.refined
    # Rows
    tail -n +2 $NODES_FILE |
        sed "s/\[\"\"//" |
        sed "s/\"\"\]//" |
        sed '1,$s/$/,\"'$LABEL_NAME'"/' >> $NODES_FILE.refined
done

# Relationships
for EDGES_FILE in import/*.edges.csv
do
    # Header
    head -n 1 $EDGES_FILE |
        sed "s/START_ID/\:START_ID/" |
        sed "s/END_ID/\:END_ID/" |
        sed "s/TYPE/\:TYPE/" > $EDGES_FILE.refined
    # Rows
     tail -n +2 $EDGES_FILE >> $EDGES_FILE.refined
done

#####Load the data in graph.db#####

rm -d -r data/databases/graph.db
mkdir data/databases/graph.db

# Import the data using neo4j-admin
bin/neo4j-admin import \
    --nodes import/paradise_papers.nodes.address.csv.refined \
    --nodes import/paradise_papers.nodes.entity.csv.refined \
    --nodes import/paradise_papers.nodes.intermediary.csv.refined \
    --nodes import/paradise_papers.nodes.officer.csv.refined \
    --nodes import/paradise_papers.nodes.other.csv.refined \
    --relationships import/paradise_papers.edges.csv.refined \
    --multiline-fields=true \
    --quote "\""

# Clean loaded data from the temp import directory
rm import/*
