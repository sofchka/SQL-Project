-- ============================================
-- INDEXES (Performance Optimization)
-- ============================================


-- ============================================
-- 1. INDEX ON USER_ID IN SUBMISSIONS
-- ============================================

-- speeds up queries filtering by user
CREATE INDEX idx_submissions_user
ON SUBMISSIONS(user_id);


-- ============================================
-- 2. INDEX ON CHALLENGE_ID IN SUBMISSIONS
-- ============================================

-- speeds up challenge-related queries
CREATE INDEX idx_submissions_challenge
ON SUBMISSIONS(challenge_id);


-- ============================================
-- 3. INDEX ON RESULT (for filtering Accepted)
-- ============================================

-- useful for leaderboard queries
CREATE INDEX idx_submissions_result
ON SUBMISSIONS(result);


-- ============================================
-- 4. INDEX ON PIXEL OWNER
-- ============================================

-- speeds up finding pixels owned by user
CREATE INDEX idx_pixels_user
ON PIXELS(user_id);


-- ============================================
-- 5. INDEX ON PIXEL COORDINATES
-- ============================================

-- improves grid lookup performance
CREATE INDEX idx_pixels_coordinates
ON PIXELS(x_coordinate, y_coordinate);


-- ============================================
-- 6. INDEX ON PIXEL HISTORY
-- ============================================

-- speeds up history queries
CREATE INDEX idx_pixelhistory_pixel
ON PIXELHISTORY(pixel_id);


-- ============================================
-- 7. INDEX ON TEST RESULTS
-- ============================================

-- improves joins between results and submissions
CREATE INDEX idx_results_submission
ON SUBMISSIONTESTRESULTS(submission_id);


-- ============================================
-- 8. INDEX ON TEST_ID
-- ============================================

-- improves lookup of test results per test case
CREATE INDEX idx_results_test
ON SUBMISSIONTESTRESULTS(test_id);


-- ============================================
-- END OF INDEXES
-- ============================================
