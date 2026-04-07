-- ===============================
-- INSERT DATA INTO USERS
-- ===============================

INSERT INTO USERS (username, email, password_hash)
VALUES
('user1', 'user1@mail.com', 'hash1'),
('user2', 'user2@mail.com', 'hash2'),
('user3', 'user3@mail.com', 'hash3'),
('user4', 'user4@mail.com', 'hash4'),
('user5', 'user5@mail.com', 'hash5'),
('user6', 'user6@mail.com', 'hash6'),
('user7', 'user7@mail.com', 'hash7'),
('user8', 'user8@mail.com', 'hash8'),
('user9', 'user9@mail.com', 'hash9'),
('user10', 'user10@mail.com', 'hash10'),
('user11', 'user11@mail.com', 'hash11'),
('user12', 'user12@mail.com', 'hash12'),
('user13', 'user13@mail.com', 'hash13'),
('user14', 'user14@mail.com', 'hash14'),
('user15', 'user15@mail.com', 'hash15'),
('user16', 'user16@mail.com', 'hash16'),
('user17', 'user17@mail.com', 'hash17'),
('user18', 'user18@mail.com', 'hash18'),
('user19', 'user19@mail.com', 'hash19'),
('user20', 'user20@mail.com', 'hash20'),
('user21', 'user21@mail.com', 'hash21'),
('user22', 'user22@mail.com', 'hash22'),
('user23', 'user23@mail.com', 'hash23'),
('user24', 'user24@mail.com', 'hash24'),
('user25', 'user25@mail.com', 'hash25'),
('user26', 'user26@mail.com', 'hash26'),
('user27', 'user27@mail.com', 'hash27'),
('user28', 'user28@mail.com', 'hash28'),
('user29', 'user29@mail.com', 'hash29'),
('user30', 'user30@mail.com', 'hash30'),
('user31', 'user31@mail.com', 'hash31'),
('user32', 'user32@mail.com', 'hash32'),
('user33', 'user33@mail.com', 'hash33'),
('user34', 'user34@mail.com', 'hash34'),
('user35', 'user35@mail.com', 'hash35'),
('user36', 'user36@mail.com', 'hash36'),
('user37', 'user37@mail.com', 'hash37'),
('user38', 'user38@mail.com', 'hash38'),
('user39', 'user39@mail.com', 'hash39'),
('user40', 'user40@mail.com', 'hash40');

-- ===============================
-- ADMINS
-- ===============================

INSERT INTO ADMINS (email, password_hash)
VALUES
('admin1@mail.com', 'adminhash1'),
('admin2@mail.com', 'adminhash2'),
('admin3@mail.com', 'adminhash3'),
('admin4@mail.com', 'adminhash4'),
('admin5@mail.com', 'adminhash5');

-- ===============================
-- CHALLENGES
-- ===============================

INSERT INTO CHALLENGES (title, description, difficulty, admin_id)
VALUES
('Sum Problem', 'Add two numbers', 'easy', 1),
('Sort Array', 'Sort numbers', 'medium', 2),
('Graph BFS', 'Find shortest path', 'hard', 3),
('Palindrome', 'Check string', 'easy', 1),
('Fibonacci', 'Compute sequence', 'medium', 2);

-- ===============================
-- TESTCASES (40+)
-- ===============================

INSERT INTO TESTCASES (input, expected_output, challenge_id, admin_id)
SELECT 
  CONCAT('input_', n),
  CONCAT('output_', n),
  (n % 5) + 1,
  (n % 5) + 1
FROM (
  SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
  UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15
  UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20
  UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
  UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30
  UNION SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35
  UNION SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) numbers;

-- ===============================
-- SUBMISSIONS (40+)
-- ===============================

INSERT INTO SUBMISSION (code, result, user_id, challenge_id)
SELECT 
  CONCAT('code_', n),
  CASE WHEN n % 2 = 0 THEN 'Accepted' ELSE 'Wrong Answer' END,
  (n % 40) + 1,
  (n % 5) + 1
FROM (
  SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
  UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15
  UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20
  UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
  UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30
  UNION SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35
  UNION SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) numbers;

-- ===============================
-- PIXELS (grid-like data)
-- ===============================

INSERT INTO PIXELS (x_coordinate, y_coordinate, color, user_id, challenge_id)
SELECT 
  n, n+1,
  'red',
  (n % 40) + 1,
  (n % 5) + 1
FROM (
  SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
  UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15
  UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20
  UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
  UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30
  UNION SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35
  UNION SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) numbers;

-- ===============================
-- PIXEL HISTORY
-- ===============================

INSERT INTO PIXELHISTORY (new_owner_id, previous_owner_id, pixel_id)
SELECT 
  (n % 40) + 1,
  ((n+1) % 40) + 1,
  n
FROM (
  SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
  UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15
  UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20
  UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
  UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30
  UNION SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35
  UNION SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) numbers;

-- ===============================
-- SUBMISSION TEST RESULTS
-- ===============================

INSERT INTO SUBMISSIONTESTRESULTS (status, execution_time, submission_id, test_id)
SELECT 
  CASE WHEN n % 2 = 0 THEN 'Passed' ELSE 'Failed' END,
  RAND(),
  (n % 40) + 1,
  (n % 40) + 1
FROM (
  SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
  UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15
  UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20
  UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
  UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30
  UNION SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35
  UNION SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40
) numbers;
