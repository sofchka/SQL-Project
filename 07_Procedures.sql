-- ============================================
-- STORED PROCEDURES
-- Reusable SQL logic
-- ============================================


-- ============================================
-- 1. GET USER SCORE (Leaderboard logic)
-- ============================================

DELIMITER $$

CREATE PROCEDURE GetUserScore(IN uid INT)
BEGIN

    SELECT COUNT(*) AS score
    FROM SUBMISSIONS
    WHERE user_id = uid
    AND result = 'Accepted';

END$$

DELIMITER ;


-- ============================================
-- 2. GET USER SUBMISSIONS
-- ============================================

DELIMITER $$

CREATE PROCEDURE GetUserSubmissions(IN uid INT)
BEGIN

    SELECT *
    FROM SUBMISSIONS
    WHERE user_id = uid;

END$$

DELIMITER ;


-- ============================================
-- 3. GET PIXELS OWNED BY USER
-- ============================================

DELIMITER $$

CREATE PROCEDURE GetUserPixels(IN uid INT)
BEGIN

    SELECT pixel_id, x_coordinate, y_coordinate, color
    FROM PIXELS
    WHERE user_id = uid;

END$$

DELIMITER ;


-- ============================================
-- 4. GET CHALLENGE STATISTICS
-- ============================================

DELIMITER $$

CREATE PROCEDURE GetChallengeStats(IN cid INT)
BEGIN

    SELECT 
        COUNT(*) AS total_submissions,
        SUM(result = 'Accepted') AS successful_submissions
    FROM SUBMISSIONS
    WHERE challenge_id = cid;

END$$

DELIMITER ;


-- ============================================
-- 5. ADD NEW SUBMISSION (WITH PARAMETERS)
-- ============================================

-- Example of inserting using procedure

DELIMITER $$

CREATE PROCEDURE AddSubmission(
    IN p_code TEXT,
    IN p_user_id INT,
    IN p_challenge_id INT
)
BEGIN

    INSERT INTO SUBMISSIONS (code, result, execution_time, user_id, challenge_id)
    VALUES (p_code, 'Wrong Answer', NULL, p_user_id, p_challenge_id);

END$$

DELIMITER ;


-- ============================================
-- 6. GET FULL SUBMISSION DETAILS
-- ============================================

DELIMITER $$

CREATE PROCEDURE GetFullSubmissionDetails()
BEGIN

    SELECT 
        u.username,
        c.title,
        s.result,
        s.execution_time,
        s.submitted_at
    FROM SUBMISSIONS s
    JOIN USERS u ON s.user_id = u.user_id
    JOIN CHALLENGES c ON s.challenge_id = c.challenge_id;

END$$

DELIMITER ;


-- ============================================
-- END OF PROCEDURES
-- ============================================
