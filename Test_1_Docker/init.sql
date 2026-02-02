CREATE TABLE IF NOT EXISTS test_table (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    message TEXT
);

INSERT INTO test_table (message) 
VALUES ('Образ создан для курса DE');
