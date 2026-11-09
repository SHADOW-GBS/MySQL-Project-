# Crownfield Eye Hospital — MySQL assessment

Author: Manoel Slavov

This repository organises the supplied MySQL scripts for EyeClinicDB. It contains a schema, a LEFT JOIN query, a stored procedure, an appointment-date trigger and a password-hashing demonstration.

## Files

| File | Contents |
| --- | --- |
| `01_schema.sql` | Nine related tables, keys and constraints |
| `02_individual_queries.sql` | Supplied patient/appointment LEFT JOIN |
| `03_procedure_and_trigger.sql` | GetPatientAppointments and CheckAppointmentDate |
| `04_security.sql` | PasswordHash column and the supplied SHA2 demonstration |
| `05_ERD/README.md` | Mermaid ERD derived from the uploaded schema |

## Running the files

Use MySQL 8.0.16 or later and MySQL Workbench. Connect to a MySQL server with permission to create a database, tables, routines and triggers.

1. Run `01_schema.sql` on a fresh database. It creates and selects `EyeClinicDB`.
2. Load your original synthetic INSERT data here, before creating the trigger if the dataset contains historical appointments. The data was not included in the uploaded files.
3. Run `02_individual_queries.sql`.
4. Run `03_procedure_and_trigger.sql` in full, including DELIMITER statements.
5. Run `04_security.sql`.

The scripts are intended for one initial execution. Re-running CREATE statements or the ADD COLUMN statement will report existing-object errors. No script drops an existing database. If EyeClinicDB already exists, use a separate test server or review the setup against your existing schema before running it.

Without INSERT data, the tables are empty, SELECT returns no rows, and the password UPDATE affects no rows. The optional commented CALL test requires your patient/appointment records.

## Still needed before a complete assessment submission

- Original INSERT statements / synthetic test data.
- Original GROUP BY / HAVING, INNER JOIN and subquery scripts. Only LEFT JOIN was supplied.
- Original UserRoles script and any permission-enforcement statements, if part of the assessment.
- Original ERD export if required by the assessment. The included diagram is derived documentation.

Any additional queries must use this schema's exact table and column names (for example, Clinician and Clinic). Queries from a separate Doctor/Department schema cannot be assumed to run unchanged.

## Behaviour and limits

- GetPatientAppointments takes PatientNumber and returns matching Appointment rows.
- CheckAppointmentDate rejects a past AppointmentDate on INSERT using MySQL error 1644. It does not validate UPDATE operations. Test intentional failure cases separately.
- SHA2(password, 256) produces a SHA-256 hash, not reversible encryption.
- The supplied security example gives all patients the same demonstration password hash. It does not create a login system or enforce role permissions.

## Preparation changes

The original SQL logic was retained. The accidental trailing text `clinicianTablesTables` was removed from the schema. `USE EyeClinicDB` was added to dependent scripts. The procedure and trigger were combined into one file. `ALTER TABLE Patient ADD COLUMN PasswordHash CHAR(64) NULL` was added because the supplied security query referenced a column absent from the supplied schema.

## Validation

Files were reviewed statically for schema references and ordering. They were not executed against a live MySQL server in this environment. Validate them in MySQL Workbench and retain your actual results as assessment evidence.

## Uploading to GitHub

Extract the ZIP first. Upload the four SQL files, README.md and the 05_ERD folder into the repository root. Upload the extracted contents, not just the ZIP, so the scripts and documentation are visible individually.
