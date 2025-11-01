CREATE TABLE IF NOT EXISTS employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  department VARCHAR(50)
);

INSERT INTO employees (name, department) VALUES
('Alice', 'Engineering'),
('Bob', 'HR'),
('Charlie', 'Finance');
