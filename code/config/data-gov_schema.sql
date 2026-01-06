/*
    Use the following columns for the new table (output from inspecting the dataframe in the notebook):

    ['COUNTY',
     'YEARS',
     'STRATA',
     'AGE GROUP',
     'CURRENT PREVALENCE',
     '95% CONFIDENCE INTERVAL',
     'COUNTIES GROUPED',
     'COMMENT']
*/
CREATE TABLE IF NOT EXISTS asthma_prevalence (
    id INTEGER PRIMARY KEY,
    county_id INTEGER,
    year_from INTEGER,
    year_to INTEGER,
    demographic_group_id INTEGER,
    current_prevalence FLOAT,
    ci_95_lower FLOAT,
    ci_95_upper FLOAT,
    comment TEXT,
    FOREIGN KEY (county_id) REFERENCES counties(county_id),
    FOREIGN KEY (demographic_group_id) REFERENCES demographic_group(id)
);

CREATE TABLE IF NOT EXISTS grouped_counties (
    -- Though it's a 1:N relationship, we create a separate table to allow for easier querying and future expansion
    county_id INTEGER,
    asthma_prevalence_id INTEGER,
    FOREIGN KEY (county_id) REFERENCES counties(county_id),
    FOREIGN KEY (asthma_prevalence_id) REFERENCES asthma_prevalence(id),
    PRIMARY KEY (county_id, asthma_prevalence_id)
);

CREATE TABLE IF NOT EXISTS demographic_group (
    id INTEGER PRIMARY KEY,
    strata TEXT,
    age_group TEXT, -- as is from the data
    age_min INTEGER,
    age_max INTEGER
);