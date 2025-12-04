CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    author_name TEXT NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    published_year INT,
    author_id INT REFERENCES authors(author_id)
);


ALTER TABLE books
ADD COLUMN genre VARCHAR(100);

ALTER TABLE books
ADD CONSTRAINT chk_published_year
CHECK (published_year <= 2025);


ALTER TABLE books
DROP COLUMN author_id;


CREATE TABLE book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    
  
    PRIMARY KEY (book_id, author_id),

   
    FOREIGN KEY (book_id) REFERENCES books(book_id),

   
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);


CREATE TABLE temp_table (
    id INT
);

DROP TABLE temp_table;
