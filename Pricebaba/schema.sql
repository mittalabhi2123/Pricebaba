-- Table containing all the data for a given data node.
-- Maintaining everything since the aim is to keep the data node 
-- as dumb as possible, as far as infrastructure is concerned.
-- Also name node need to have db details of data node, to connect to it, for picking and processing data
-- This will help in following:
	-- Plugging in and out the data node will be easy
	-- Changing configurations of data node will be easy. Don't have to change the software running on data node.
	-- The case where db is running on different port# on different nodes will be handled seamlessly.
	-- By each data node having its own db, will possess less load on name node/server, when multiple crawling requests will be posted in parallel.
CREATE TABLE data_node (
	node_id			int,
	node_ip			varchar(20),
	node_port		decimal(6), -- port on which to connect to
	node_active		decimal(1),
	node_db_port		decimal(6),
	node_db_driver		varchar(100), -- driver class to connect to for this node.
	node_db_conn_string	varchar(100), -- db connection string for this node.
	node_db_user		varchar(50),
	node_password		varchar(50),
	node_vendor		varchar(50), -- could be aws/solarvps etc.
	node_crawl_category	varchar(50), -- for future use, in case it's required to keep separate nodes for separate category like phone/laptop etc.
	PRIMARY KEY (node_id)
);

-- contains the record for each execution request for each data node.
CREATE TABLE execution_summary (
	execution_id		int,
	node_id			int,
	requested_time		timestamp,
	completion_time		timestamp,
	execution_result	varchar(10), -- PASS/FAIL/PROGRESS
	result_processed	decimal(1), -- status to be updated when name node finishes with the processing of the crawled content.
	execution_category	varchar(50), -- category for which it has been executed.
	PRIMARY KEY (execution_id)
);

-- contains all the errors produced by this client for the failure of given execution request
CREATE TABLE execution_errors (
	execution_id		int,
	error_id		int,
	error_message		varchar(500),
	PRIMARY KEY (execution_id, error_id)
);

-- contains all the urls processed by this client for a given execution request
CREATE TABLE execution_url (
	execution_id		int,
	url_id			int,
	error_message		varchar(500),
	PRIMARY KEY (execution_id, error_id)
);
