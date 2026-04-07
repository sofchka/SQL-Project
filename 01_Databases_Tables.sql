-- ===============================
-- DATABASE CREATION
-- ===============================

CREATE DATABASE PixelPlatform;
USE PixelPlatform;

-- ===============================
-- USERS TABLE
-- ===============================

CREATE TABLE USERS
(
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE, -- enforce unique usernames
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- ADMINS TABLE
-- ===============================

CREATE TABLE ADMINS
(
  admin_id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL
);

-- ===============================
-- CHALLENGES TABLE
-- ===============================

CREATE TABLE CHALLENGES
(
  challenge_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,

  -- ENUM ensures only valid difficulty values
  difficulty ENUM('easy', 'medium', 'hard') NOT NULL,

  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  admin_id INT NOT NULL,

  FOREIGN KEY (admin_id) REFERENCES ADMINS(admin_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ===============================
-- PIXELS TABLE
-- ===============================

CREATE TABLE PIXELS
(
  pixel_id INT PRIMARY KEY AUTO_INCREMENT,

  x_coordinate INT NOT NULL,
  y_coordinate INT NOT NULL,

  color VARCHAR(20) NOT NULL,

  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- pixel can be unowned initially
  user_id INT NULL,

  challenge_id INT NOT NULL,

  -- ensure unique grid position
  UNIQUE (x_coordinate, y_coordinate),

  -- ensure valid coordinates
  CHECK (x_coordinate >= 0 AND y_coordinate >= 0),

  FOREIGN KEY (user_id) REFERENCES USERS(user_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,

  FOREIGN KEY (challenge_id) REFERENCES CHALLENGES(challenge_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ===============================
-- SUBMISSIONS TABLE (FIXED NAME + execution_time)
-- ===============================

CREATE TABLE SUBMISSIONS
(
  submission_id INT PRIMARY KEY AUTO_INCREMENT,

  code TEXT NOT NULL,

  submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  -- ENUM instead of VARCHAR for correctness
  result ENUM('Accepted', 'Wrong Answer', 'Time Limit', 'Runtime Error') NOT NULL,

  execution_time FLOAT, -- added missing field

  user_id INT NOT NULL,
  challenge_id INT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES USERS(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (challenge_id) REFERENCES CHALLENGES(challenge_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ===============================
-- TESTCASES TABLE
-- ===============================

CREATE TABLE TESTCASES
(
  test_id INT PRIMARY KEY AUTO_INCREMENT,

  input TEXT NOT NULL,
  expected_output TEXT NOT NULL,

  challenge_id INT NOT NULL,
  admin_id INT NOT NULL,

  FOREIGN KEY (challenge_id) REFERENCES CHALLENGES(challenge_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (admin_id) REFERENCES ADMINS(admin_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ===============================
-- PIXEL HISTORY TABLE
-- ===============================

CREATE TABLE PIXELHISTORY
(
  history_id INT PRIMARY KEY AUTO_INCREMENT,

  pixel_id INT NOT NULL,

  new_owner_id INT NOT NULL,
  previous_owner_id INT NULL,

  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (pixel_id) REFERENCES PIXELS(pixel_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (new_owner_id) REFERENCES USERS(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (previous_owner_id) REFERENCES USERS(user_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- ===============================
-- SUBMISSION TEST RESULTS TABLE
-- ===============================

CREATE TABLE SUBMISSIONTESTRESULTS
(
  result_id INT PRIMARY KEY AUTO_INCREMENT,

  status ENUM('Passed', 'Failed') NOT NULL,

  execution_time FLOAT,

  submission_id INT NOT NULL,
  test_id INT NOT NULL,

  FOREIGN KEY (submission_id) REFERENCES SUBMISSIONS(submission_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  FOREIGN KEY (test_id) REFERENCES TESTCASES(test_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- ===============================
-- INDEXES (performance optimization)
-- ===============================

CREATE INDEX idx_submission_user ON SUBMISSIONS(user_id);
CREATE INDEX idx_submission_challenge ON SUBMISSIONS(challenge_id);
CREATE INDEX idx_pixel_owner ON PIXELS(user_id);
