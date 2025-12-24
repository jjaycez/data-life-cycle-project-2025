CREATE TABLE IF NOT EXISTS units(
    unit_id INTEGER PRIMARY KEY,
    unit_name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS pollutants(
    pollutant_id INTEGER PRIMARY KEY,
    pollutant_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS stations(
    station_id INTEGER PRIMARY KEY,
    county_id INTEGER,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    FOREIGN KEY (county_id) REFERENCES counties(county_id)
);

CREATE TABLE IF NOT EXISTS counties(
    county_id INTEGER PRIMARY KEY,
    county_name VARCHAR(100) NOT NULL,
    geometry TEXT
);

CREATE TABLE IF NOT EXISTS sensors(
    sensor_id INTEGER PRIMARY KEY,
    station_id INTEGER,
    pollutant_id INTEGER,
    unit_id INTEGER,
    FOREIGN KEY (station_id) REFERENCES stations(station_id),
    FOREIGN KEY (pollutant_id) REFERENCES pollutants(pollutant_id),
    FOREIGN KEY (unit_id) REFERENCES units(unit_id)
);

CREATE TABLE IF NOT EXISTS measurements(
    measurement_id INTEGER PRIMARY KEY,
    sensor_id INTEGER,
    measurement_value DECIMAL(10,4) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id),
    UNIQUE(sensor_id, start_time, end_time)
);