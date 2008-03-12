CREATE TABLE trees (
    id serial NOT NULL,
    parent_id int4 NULL,
    pos  int4 NULL,
    lft  int4 NULL,
    rgt  int4 NULL,
    root_id  int4 NULL,
    data text NOT NULL,
    moduser_id int4 NULL
        REFERENCES users(id)
        ON UPDATE CASCADE
        DEFERRABLE,
    created_on timestamp DEFAULT CURRENT_TIMESTAMP,
    updated_on timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
