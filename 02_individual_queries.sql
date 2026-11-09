-- Original LEFT JOIN from SELECT.sql.
-- Other individual queries have not yet been supplied.
USE EyeClinicDB;

SELECT
    p.PatientID,
    p.PatientName,
    a.AppointmentID,
    a.AppointmentDate
FROM Patient p
LEFT JOIN Appointment a
    ON p.PatientID = a.PatientID;
