-- TIMESTAMP: stores date and time, DEFAULT CURRENT_TIMESTAMP = auto set current time

CREATE TABLE USERS
(
  user_id INT PRIMARY KEY AUTO_INCREMENT, -- AUTO_INCREMENT: auto increases id
  username VARCHAR(50) NOT NULL,          -- VARCHAR: variable length string
  email VARCHAR(100) NOT NULL UNIQUE,     -- UNIQUE: no duplicate values
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ADMINS
(
  admin_id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL
);

-- TEXT: for long text (like descriptions or code)
-- ENUM: restrict values to predefined list

CREATE TABLE CHALLENGES
(
  challenge_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  difficulty ENUM('easy', 'medium', 'hard') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  solved_at TIMESTAMP NULL,               -- NULL: value can be empty
  admin_id INT NOT NULL,
  FOREIGN KEY (admin_id) REFERENCES ADMINS(admin_id) -- FOREIGN KEY: link to another table
);

-- UNIQUE(x, y): ensures no duplicate coordinate pairs

CREATE TABLE PIXELS
(
  pixel_id INT PRIMARY KEY AUTO_INCREMENT,
  x_coordinate INT NOT NULL,
  y_coordinate INT NOT NULL,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  color VARCHAR(20) NOT NULL,
  user_id INT,
  challenge_id INT,

  UNIQUE (x_coordinate, y_coordinate),

  FOREIGN KEY (user_id) REFERENCES USERS(user_id),
  FOREIGN KEY (challenge_id) REFERENCES CHALLENGES(challenge_id)
);

CREATE TABLE SUBMISSION
(
  submission_id INT PRIMARY KEY AUTO_INCREMENT,
  code TEXT NOT NULL,
  submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  result VARCHAR(20) NOT NULL,
  user_id INT NOT NULL,
  challenge_id INT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES USERS(user_id),
  FOREIGN KEY (challenge_id) REFERENCES CHALLENGES(challenge_id)
);

CREATE TABLE TESTCASES
(
  test_id INT PRIMARY KEY AUTO_INCREMENT,
  input TEXT NOT NULL,
  expected_output TEXT NOT NULL,
  challenge_id INT NOT NULL,
  admin_id INT NOT NULL,

  FOREIGN KEY (challenge_id) REFERENCES CHALLENGES(challenge_id),
  FOREIGN KEY (admin_id) REFERENCES ADMINS(admin_id)
);

CREATE TABLE PIXELHISTORY
(
  history_id INT PRIMARY KEY AUTO_INCREMENT,
  new_owner_id INT NOT NULL,
  previous_owner_id INT,
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  pixel_id INT NOT NULL,

  FOREIGN KEY (pixel_id) REFERENCES PIXELS(pixel_id),
  FOREIGN KEY (new_owner_id) REFERENCES USERS(user_id),
  FOREIGN KEY (previous_owner_id) REFERENCES USERS(user_id)
);

-- FLOAT: decimal number (used for execution time)

CREATE TABLE SUBMISSIONTESTRESULTS
(
  result_id INT PRIMARY KEY AUTO_INCREMENT,
  status VARCHAR(20) NOT NULL,
  execution_time FLOAT,
  submission_id INT NOT NULL,
  test_id INT NOT NULL,

  FOREIGN KEY (submission_id) REFERENCES SUBMISSION(submission_id),
  FOREIGN KEY (test_id) REFERENCES TESTCASES(test_id)
);

-- INDEX: speeds up search queries

CREATE INDEX idx_submission_user ON SUBMISSION(user_id);
