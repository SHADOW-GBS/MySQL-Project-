-- Run once after 01_schema.sql.
USE EyeClinicDB;

-- Added because the supplied schema has no PasswordHash column.
-- SHA-256 is represented by 64 hexadecimal characters.
ALTER TABLE Patient ADD COLUMN PasswordHash CHAR(64) NULL;

-- Original demonstration query: sets the same test-password hash for all patients.
-- Use synthetic assessment data only. This is not a complete login system.
UPDATE Patient
SET PasswordHash = SHA2('Password123',256);

SELECT PatientID, PatientName, PasswordHash
FROM Patient;

-- UserRoles / actual GRANT statements were not included in the uploaded SQL.
