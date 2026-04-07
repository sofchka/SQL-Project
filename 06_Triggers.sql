-- ============================================
-- TRIGGERS
-- Automatically executed when events happen
-- ============================================


-- ============================================
-- 1. TRIGGER: ASSIGN PIXEL AFTER SUCCESSFUL SUBMISSION
-- ============================================

-- When a new submission is inserted:
-- If result = 'Accepted', assign a pixel to that user

DELIMITER $$

CREATE TRIGGER assign_pixel_after_success
AFTER INSERT ON SUBMISSIONS
FOR EACH ROW
BEGIN

    -- IF condition checks the inserted row (NEW)
    IF NEW.result = 'Accepted' THEN

        -- assign a pixel that belongs to the challenge
        UPDATE PIXELS
        SET user_id = NEW.user_id
        WHERE challenge_id = NEW.challenge_id
        AND user_id IS NULL   -- only free pixels
        LIMIT 1;

    END IF;

END$$

DELIMITER ;


-- ============================================
-- 2. TRIGGER: LOG PIXEL OWNERSHIP CHANGES
-- ============================================

-- When a pixel owner changes, store it in PIXELHISTORY

DELIMITER $$

CREATE TRIGGER log_pixel_change
AFTER UPDATE ON PIXELS
FOR EACH ROW
BEGIN

    -- check if owner changed
    IF OLD.user_id <> NEW.user_id THEN

        INSERT INTO PIXELHISTORY (
            pixel_id,
            previous_owner_id,
            new_owner_id
        )
        VALUES (
            OLD.pixel_id,
            OLD.user_id,
            NEW.user_id
        );

    END IF;

END$$

DELIMITER ;


-- ============================================
-- 3. TRIGGER: PREVENT TOO FAST SUBMISSIONS
-- ============================================

-- Prevent user from submitting too frequently (e.g. < 5 seconds)

DELIMITER $$

CREATE TRIGGER prevent_fast_submissions
BEFORE INSERT ON SUBMISSIONS
FOR EACH ROW
BEGIN

    DECLARE last_time TIMESTAMP;

    -- get last submission time of this user for this challenge
    SELECT MAX(submitted_at)
    INTO last_time
    FROM SUBMISSIONS
    WHERE user_id = NEW.user_id
    AND challenge_id = NEW.challenge_id;

    -- check time difference
    IF last_time IS NOT NULL AND TIMESTAMPDIFF(SECOND, last_time, NOW()) < 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Submission too fast. Please wait.';
    END IF;

END$$

DELIMITER ;


-- ============================================
-- END OF TRIGGERS
-- ============================================
