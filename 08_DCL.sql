-- ============================================
-- DCL (Data Control Language)
-- Manage user permissions and access
-- ============================================


-- ============================================
-- 1. CREATE USERS (database accounts)
-- ============================================

-- create a normal application user
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'password123';

-- create an admin user
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin123';


-- ============================================
-- 2. GRANT PERMISSIONS
-- ============================================

-- give basic permissions to app_user
-- SELECT = read data
-- INSERT = add data
-- UPDATE = modify data

GRANT SELECT, INSERT, UPDATE
ON PixelPlatform.* 
TO 'app_user'@'localhost';


-- ============================================
-- 3. RESTRICT DELETE (security)
-- ============================================

-- do NOT allow app_user to delete data
-- (we simply don’t grant DELETE permission)


-- ============================================
-- 4. ADMIN FULL ACCESS
-- ============================================

-- admin can do everything
GRANT ALL PRIVILEGES
ON PixelPlatform.*
TO 'admin_user'@'localhost';


-- ============================================
-- 5. APPLY CHANGES
-- ============================================

-- reload privileges (important in MySQL)
FLUSH PRIVILEGES;


-- ============================================
-- 6. REVOKE PERMISSIONS (optional example)
-- ============================================

-- remove update permission from app_user
-- (example of restricting access)

REVOKE UPDATE
ON PixelPlatform.*
FROM 'app_user'@'localhost';


-- ============================================
-- END OF DCL
-- ============================================
