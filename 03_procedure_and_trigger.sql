-- Run once after 01_schema.sql.
USE EyeClinicDB;

-- Stored procedure
DELIMITER //

CREATE PROCEDURE GetPatientAppointments
(
    IN PatientNumber VARCHAR(10)
)
BEGIN

SELECT *
FROM Appointment
WHERE PatientID = PatientNumber;

END //

DELIMITER ;

-- Trigger
DELIMITER //

CREATE TRIGGER CheckAppointmentDate
BEFORE INSERT ON Appointment
FOR EACH ROW
BEGIN
    IF NEW.AppointmentDate < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment date cannot be in the past';
    END IF;
END //

DELIMITER ;

-- Optional procedure test, after loading patient and appointment data:
-- CALL GetPatientAppointments('P001');
-- The trigger rejects past dates on INSERT only, not on UPDATE.
