DROP TABLE IF EXISTS datapoint;
DROP TABLE IF EXISTS ssid;
DROP TABLE IF EXISTS workspace;
DROP VIEW IF EXISTS view1;

CREATE TABLE datapoint(
    id INTEGER PRIMARY KEY NOT NULL,
    workspace_num INTEGER NOT NULL,
    ssid_num INTEGER NOT NULL,
    timestamp TEXT NOT NULL,
    windowname TEXT NOT NULL
);

CREATE TABLE ssid(
    number INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
);

CREATE TABLE workspace(
    number INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    timestamp INTEGER NOT NULL
);

CREATE VIEW view1(workspace, ssid, timestamp, windowname) AS
    SELECT workspace.name, ssid.name, datapoint.timestamp, windowname
    FROM datapoint
        LEFT JOIN workspace ON datapoint.workspace_num = workspace.number
        LEFT JOIN ssid ON datapoint.ssid_num = ssid.number
;

CREATE TRIGGER view_write
    INSTEAD OF INSERT
    ON view1
    BEGIN
        INSERT INTO ssid (name) VALUES (NEW.ssid);
        INSERT INTO workspace (name, timestamp) VALUES (NEW.workspace, date('now'));
    END


INSERT INTO datapoint VALUES (0, 0, 0, 160134, 'firefox');
INSERT INTO datapoint VALUES (1, 0, 0, 160136, 'firefox');

INSERT INTO ssid VALUES (0, 'eduroam');

INSERT INTO workspace VALUES (0, 'main', 160134);
