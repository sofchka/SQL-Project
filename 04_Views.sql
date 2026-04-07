-- ============================================
-- VIEWS (Virtual Tables)
-- Used to store reusable queries
-- ============================================


-- ============================================
-- 1. LEADERBOARD VIEW
-- ============================================

-- This view calculates user scores based on accepted submissions
CREATE VIEW LeaderboardView AS
SELECT 
    user_id,
    COUNT(*) AS score  -- COUNT counts number of rows
FROM SUBMISSIONS
WHERE result = 'Accepted'
GROUP BY user_id;


-- ============================================
-- 2. USER SUBMISSION HISTORY VIEW
-- ============================================

-- Shows all submissions with user information
CREATE VIEW UserSubmissionHistory AS
SELECT 
    u.username,
    s.submission_id,
    s.result,
    s.execution_time,
    s.submitted_at
FROM SUBMISSIONS s
JOIN USERS u ON s.user_id = u.user_id;


-- ============================================
-- 3. FULL SUBMISSION DETAILS VIEW
-- ============================================

-- Combines user + challenge + submission
CREATE VIEW FullSubmissionDetails AS
SELECT 
    u.username,
    c.title AS challenge_title,
    s.result,
    s.execution_time,
    s.submitted_at
FROM SUBMISSIONS s
JOIN USERS u ON s.user_id = u.user_id
JOIN CHALLENGES c ON s.challenge_id = c.challenge_id;


-- ============================================
-- 4. PIXEL OWNERSHIP VIEW
-- ============================================

-- Shows who owns each pixel (if any)
CREATE VIEW PixelOwnershipView AS
SELECT 
    p.pixel_id,
    p.x_coordinate,
    p.y_coordinate,
    p.color,
    u.username
FROM PIXELS p
LEFT JOIN USERS u ON p.user_id = u.user_id;

-- LEFT JOIN ensures pixels without owners still appear


-- ============================================
-- 5. PIXEL HISTORY VIEW
-- ============================================

-- Shows ownership changes with usernames
CREATE VIEW PixelHistoryView AS
SELECT 
    ph.pixel_id,
    u1.username AS new_owner,
    u2.username AS previous_owner,
    ph.changed_at
FROM PIXELHISTORY ph
LEFT JOIN USERS u1 ON ph.new_owner_id = u1.user_id
LEFT JOIN USERS u2 ON ph.previous_owner_id = u2.user_id;


-- ============================================
-- 6. TEST CASE RESULTS VIEW
-- ============================================

-- Shows detailed results for submissions
CREATE VIEW SubmissionTestResultsView AS
SELECT 
    s.submission_id,
    t.test_id,
    t.input,
    t.expected_output,
    r.status,
    r.execution_time
FROM SUBMISSIONTESTRESULTS r
JOIN SUBMISSIONS s ON r.submission_id = s.submission_id
JOIN TESTCASES t ON r.test_id = t.test_id;


-- ============================================
-- 7. CHALLENGE PERFORMANCE VIEW
-- ============================================

-- Shows number of attempts per challenge
CREATE VIEW ChallengeStatsView AS
SELECT 
    c.challenge_id,
    c.title,
    COUNT(s.submission_id) AS total_attempts
FROM CHALLENGES c
LEFT JOIN SUBMISSIONS s ON c.challenge_id = s.challenge_id
GROUP BY c.challenge_id, c.title;


-- ============================================
-- END OF VIEWS
-- ============================================
