-- Run once on a fresh MySQL database. No existing database is deleted.
-- The uploaded files contain no patient/appointment INSERT data.

CREATE DATABASE EyeClinicDB;
USE EyeClinicDB;

-- PATIENT
CREATE TABLE Patient (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    Postcode VARCHAR(10) NOT NULL
);

-- CLINICIAN
CREATE TABLE Clinician (
    ClinicianID VARCHAR(10) PRIMARY KEY,
    ClinicianName VARCHAR(100) NOT NULL,
    Specialty VARCHAR(50) NOT NULL
);

-- CLINIC
CREATE TABLE Clinic (
    ClinicID VARCHAR(10) PRIMARY KEY,
    ClinicName VARCHAR(100) NOT NULL UNIQUE
);

-- APPOINTMENT
CREATE TABLE Appointment (
    AppointmentID VARCHAR(10) PRIMARY KEY,
    PatientID VARCHAR(10) NOT NULL,
    ClinicianID VARCHAR(10) NOT NULL,
    ClinicID VARCHAR(10) NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Notes VARCHAR(255),

    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (PatientID)
        REFERENCES Patient(PatientID),

    CONSTRAINT fk_appointment_clinician
        FOREIGN KEY (ClinicianID)
        REFERENCES Clinician(ClinicianID),

    CONSTRAINT fk_appointment_clinic
        FOREIGN KEY (ClinicID)
        REFERENCES Clinic(ClinicID)
);

-- DIAGNOSIS
CREATE TABLE Diagnosis (
    DiagnosisID VARCHAR(10) PRIMARY KEY,
    AppointmentID VARCHAR(10) NOT NULL,
    DiagnosisText VARCHAR(255) NOT NULL,

    CONSTRAINT fk_diagnosis_appointment
        FOREIGN KEY (AppointmentID)
        REFERENCES Appointment(AppointmentID)
);

-- PRESCRIPTION
CREATE TABLE Prescription (
    PrescriptionID VARCHAR(10) PRIMARY KEY,
    AppointmentID VARCHAR(10) NOT NULL,

    CONSTRAINT fk_prescription_appointment
        FOREIGN KEY (AppointmentID)
        REFERENCES Appointment(AppointmentID)
);

-- MEDICINE
CREATE TABLE Medicine (
    MedicineID VARCHAR(10) PRIMARY KEY,
    MedicineName VARCHAR(100) NOT NULL UNIQUE
);

-- PRESCRIPTION ITEM
CREATE TABLE PrescriptionItem (
    PrescriptionID VARCHAR(10),
    MedicineID VARCHAR(10),
    Dose VARCHAR(50) NOT NULL,
    Route VARCHAR(50) NOT NULL,
    Frequency VARCHAR(50) NOT NULL,
    Duration VARCHAR(50) NOT NULL,

    PRIMARY KEY (PrescriptionID, MedicineID),

    CONSTRAINT fk_pi_prescription
        FOREIGN KEY (PrescriptionID)
        REFERENCES Prescription(PrescriptionID),

    CONSTRAINT fk_pi_medicine
        FOREIGN KEY (MedicineID)
        REFERENCES Medicine(MedicineID)
);

-- FOLLOW UP
CREATE TABLE FollowUp (
    FollowUpID VARCHAR(10) PRIMARY KEY,
    AppointmentID VARCHAR(10) NOT NULL,
    DueDate DATE NOT NULL,
    Priority VARCHAR(20) DEFAULT 'Medium',
    Status VARCHAR(20) DEFAULT 'Pending',

    CONSTRAINT fk_followup_appointment
        FOREIGN KEY (AppointmentID)
        REFERENCES Appointment(AppointmentID),

    CONSTRAINT chk_priority
        CHECK (Priority IN ('Low', 'Medium', 'High')),

    CONSTRAINT chk_status
        CHECK (Status IN ('Pending', 'Completed', 'Cancelled'))
);
