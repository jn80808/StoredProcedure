CREATE TABLE Patients (
    PatientId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    FirstName VARCHAR(100),
    MiddleName VARCHAR(100),
    LastName VARCHAR(100),
    PreferredName VARCHAR(100),
    BirthDate DATE,
    Age INT,
    Sex VARCHAR(10),
    SocialSecurityNumber VARCHAR(20),
    PreferredLanguage VARCHAR(50),
    Ethnicity VARCHAR(255),
    MaritalStatus VARCHAR(20),
    Occupation VARCHAR(100),
    Employer VARCHAR(100),
    Email VARCHAR(100),
    PhoneHome VARCHAR(20),
    PhoneWork VARCHAR(20),
    PhoneCell VARCHAR(20),
    PreferredContact VARCHAR(10),
    AddressStreet TEXT,
    AddressCity VARCHAR(50),
    AddressState VARCHAR(50),
    AddressZip VARCHAR(20),
    BillingStreet TEXT,
    BillingCity VARCHAR(50),
    BillingState VARCHAR(50),
    BillingZip VARCHAR(20)
);


CREATE TABLE Insurance (
    InsuranceId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PatientId UNIQUEIDENTIFIER REFERENCES Patients(PatientId),
    InsuranceType VARCHAR(20), -- Primary / Secondary
    PolicyNumber VARCHAR(50),
    SubscriberName VARCHAR(100),
    SubscriberDOB DATE
);


CREATE TABLE EmergencyContacts (
    ContactId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PatientId UNIQUEIDENTIFIER REFERENCES Patients(PatientId),
    ContactType VARCHAR(30), -- e.g. NextOfKin / Emergency
    Name VARCHAR(100),
    Relationship VARCHAR(50),
    PhoneHome VARCHAR(20),
    PhoneCell VARCHAR(20)
);


CREATE TABLE ResponsibleParties (
    ResponsibleId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PatientId UNIQUEIDENTIFIER REFERENCES Patients(PatientId),
    Name VARCHAR(100),
    DOB DATE,
    RelationshipToInsured VARCHAR(50),
    PreferredPhone VARCHAR(20)
);


CREATE TABLE Vitals (
    VitalsId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PatientId UNIQUEIDENTIFIER REFERENCES Patients(PatientId),
    HeightInches FLOAT,
    WeightLbs FLOAT,
    ShoeSize VARCHAR(10),
    GenderShoe VARCHAR(10),
    HemoglobinA1C FLOAT,
    A1CDate DATE
);


CREATE TABLE Allergies (
    AllergyId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PatientId UNIQUEIDENTIFIER REFERENCES Patients(PatientId),
    AllergyType VARCHAR(100),
    OtherAllergyNotes TEXT
);


CREATE TABLE Medications (
    MedicationId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PatientId UNIQUEIDENTIFIER REFERENCES Patients(PatientId),
    MedicationName VARCHAR(100),
    Dose VARCHAR(50),
    Frequency VARCHAR(50),
    TakingOralContraceptives BIT
);


CREATE TABLE LaboratoryResults (
    LabId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PatientId UNIQUEIDENTIFIER REFERENCES Patients(PatientId),
    TestType VARCHAR(100),
    ResultSummary TEXT,
    FullReport TEXT,
    ResultDate DATE,
    UploadedBy VARCHAR(100)
);


CREATE TABLE PatientStatus (
    StatusId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    PatientId UNIQUEIDENTIFIER REFERENCES Patients(PatientId),
    Status VARCHAR(50), -- e.g. Stable, Critical
    UpdatedOn DATETIME DEFAULT GETDATE(),
    UpdatedBy VARCHAR(100)
);


INSERT INTO Patients (PatientId, FirstName, MiddleName, LastName, PreferredName, BirthDate, Age, Sex, SocialSecurityNumber,
PreferredLanguage, Ethnicity, MaritalStatus, Occupation, Employer, Email, PhoneHome, PhoneWork, PhoneCell, PreferredContact,
AddressStreet, AddressCity, AddressState, AddressZip, BillingStreet, BillingCity, BillingState, BillingZip)
VALUES
(NEWID(), 'John', 'A.', 'Doe', 'Johnny', '1985-05-20', 39, 'Male', '123-45-6789', 'English', 'Caucasian', 'Married', 'Engineer', 'ABC Corp', 'john.doe@example.com', '1234567890', '0987654321', '1122334455', 'Cell', '123 Main St', 'Cityville', 'StateA', '12345', '456 Elm St', 'Cityville', 'StateA', '12345'),
(NEWID(), 'Jane', 'B.', 'Smith', 'Janey', '1990-07-12', 34, 'Female', '987-65-4321', 'English', 'Asian', 'Single', 'Teacher', 'XYZ School', 'jane.smith@example.com', '2345678901', '9876543210', '2233445566', 'Home', '789 Oak St', 'Townsville', 'StateB', '67890', '101 Pine St', 'Townsville', 'StateB', '67890'),
(NEWID(), 'Alice', NULL, 'Johnson', NULL, '1978-11-02', 46, 'Female', '111-22-3333', 'Spanish', 'Hispanic', 'Widowed', 'Nurse', 'City Hospital', 'alice.j@example.com', '3456789012', NULL, '3344556677', 'Cell', '222 Maple Rd', 'Metrocity', 'StateC', '13579', '222 Maple Rd', 'Metrocity', 'StateC', '13579'),
(NEWID(), 'Bob', 'C.', 'Lee', NULL, '2000-01-15', 25, 'Male', '444-55-6666', 'Chinese', 'Asian', 'Single', 'Student', NULL, 'bob.lee@example.com', NULL, NULL, '4455667788', 'Cell', '321 Birch Ln', 'Uptown', 'StateD', '24680', '321 Birch Ln', 'Uptown', 'StateD', '24680'),
(NEWID(), 'Carol', 'D.', 'Nguyen', NULL, '1995-03-25', 30, 'Female', '555-66-7777', 'Vietnamese', 'Asian', 'Married', 'Analyst', 'TechCo', 'carol.n@example.com', '4567890123', '8765432109', '5566778899', 'Work', '654 Cedar Dr', 'Oldtown', 'StateE', '11223', '654 Cedar Dr', 'Oldtown', 'StateE', '11223');




SELECT * FROM Patients


INSERT INTO Insurance (InsuranceId, PatientId, InsuranceType, PolicyNumber, SubscriberName, SubscriberDOB)
SELECT NEWID(), PatientId, 'Primary', 'POL12345', 'John Doe', '1985-05-20' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Secondary', 'POL67890', 'Jane Smith', '1990-07-12' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Primary', 'POL11111', 'Alice Johnson', '1978-11-02' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Primary', 'POL22222', 'Bob Lee', '2000-01-15' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Primary', 'POL33333', 'Carol Nguyen', '1995-03-25' FROM Patients;


INSERT INTO ResponsibleParties (ResponsibleId, PatientId, Name, DOB, RelationshipToInsured, PreferredPhone)
SELECT NEWID(), PatientId, 'Mary Doe', '1960-01-01', 'Mother', '1112223333' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Robert Smith', '1955-02-02', 'Father', '2223334444' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Emma Johnson', '1980-03-03', 'Sister', '3334445555' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Linda Lee', '1970-04-04', 'Aunt', '4445556666' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'David Nguyen', '1965-05-05', 'Uncle', '5556667777' FROM Patients;

INSERT INTO ResponsibleParties (ResponsibleId, PatientId, Name, DOB, RelationshipToInsured, PreferredPhone)
SELECT NEWID(), PatientId, 'Mary Doe', '1960-01-01', 'Mother', '1112223333' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Robert Smith', '1955-02-02', 'Father', '2223334444' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Emma Johnson', '1980-03-03', 'Sister', '3334445555' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Linda Lee', '1970-04-04', 'Aunt', '4445556666' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'David Nguyen', '1965-05-05', 'Uncle', '5556667777' FROM Patients;

INSERT INTO Vitals (VitalsId, PatientId, HeightInches, WeightLbs, ShoeSize, GenderShoe, HemoglobinA1C, A1CDate)
SELECT NEWID(), PatientId, 70.0, 160.5, '10', 'Male', 5.5, '2024-12-01' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 65.0, 130.0, '7', 'Female', 6.2, '2024-12-15' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 62.0, 120.0, '6', 'Female', 5.9, '2025-01-10' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 68.0, 150.0, '9', 'Male', 5.2, '2025-02-20' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 64.0, 140.0, '8', 'Female', 6.5, '2025-03-05' FROM Patients;


INSERT INTO Allergies (AllergyId, PatientId, AllergyType, OtherAllergyNotes)
SELECT NEWID(), PatientId, 'Peanuts', 'Severe reaction' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Shellfish', 'Moderate hives' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Pollen', 'Seasonal allergy' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Dust', 'Mild sneezing' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Latex', 'Contact allergy' FROM Patients;

INSERT INTO Medications (MedicationId, PatientId, MedicationName, Dose, Frequency, TakingOralContraceptives)
SELECT NEWID(), PatientId, 'Metformin', '500mg', 'Twice daily', 0 FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Ibuprofen', '200mg', 'As needed', 0 FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Amoxicillin', '250mg', 'Three times daily', 0 FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Lisinopril', '10mg', 'Once daily', 0 FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Ortho Tri-Cyclen', '1 tab', 'Once daily', 1 FROM Patients;

INSERT INTO Medications (MedicationId, PatientId, MedicationName, Dose, Frequency, TakingOralContraceptives)
SELECT NEWID(), PatientId, 'Metformin', '500mg', 'Twice daily', 0 FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Ibuprofen', '200mg', 'As needed', 0 FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Amoxicillin', '250mg', 'Three times daily', 0 FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Lisinopril', '10mg', 'Once daily', 0 FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Ortho Tri-Cyclen', '1 tab', 'Once daily', 1 FROM Patients;

INSERT INTO LaboratoryResults (LabId, PatientId, TestType, ResultSummary, FullReport, ResultDate, UploadedBy)
SELECT NEWID(), PatientId, 'Blood Test', 'Normal', 'No abnormalities', '2025-01-15', 'Dr. Adams' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'X-Ray', 'No fractures', 'Clear lungs', '2025-02-01', 'Dr. Baker' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'MRI', 'Minor disc bulge', 'Recommend PT', '2025-02-15', 'Dr. Clark' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Urinalysis', 'Normal', 'No infections', '2025-03-01', 'Dr. Davis' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'COVID-19', 'Negative', 'RT-PCR Negative', '2025-03-15', 'Dr. Ellis' FROM Patients;



INSERT INTO PatientStatus (StatusId, PatientId, Status, UpdatedOn, UpdatedBy)
SELECT NEWID(), PatientId, 'Stable', GETDATE(), 'Nurse A' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Critical', GETDATE(), 'Nurse B' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Recovering', GETDATE(), 'Nurse C' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Stable', GETDATE(), 'Nurse D' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Observation', GETDATE(), 'Nurse E' FROM Patients;


INSERT INTO EmergencyContacts (ContactId, PatientId, ContactType, Name, Relationship, PhoneHome, PhoneCell)
SELECT NEWID(), PatientId, 'NextOfKin', 'Maria Doe', 'Mother', '1212121212', '1313131313' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Emergency', 'Jake Smith', 'Brother', NULL, '1414141414' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Emergency', 'Olivia Johnson', 'Friend', '1515151515', '1616161616' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'NextOfKin', 'Anna Lee', 'Sister', NULL, '1717171717' FROM Patients
UNION ALL SELECT NEWID(), PatientId, 'Emergency', 'Mark Nguyen', 'Cousin', '1818181818', '1919191919' FROM Patients;

SELECT 
    MedicationId, PatientId, MedicationName, Dose, Frequency, TakingOralContraceptives
FROM Medications;


ALTER TABLE Patients
ALTER COLUMN AddressStreet VARCHAR(255);

ALTER TABLE Patients
ALTER COLUMN BillingStreet VARCHAR(255);



ALTER TABLE Patients
ADD Operation VARCHAR(255) NULL;



EXEC sp_rename 'Patients', 'Tbl_Patients';

EXEC Prc_PersonalData 
@OPERATION ='GENERATEID'


ALTER TABLE Tbl_Patients
ADD CreatedAt DATETIME DEFAULT GETDATE();



ALTER TABLE Tbl_Patients
ADD PatientIdNumber INT NULL;


ALTER TABLE Tbl_Patients
DROP COLUMN PatientIdNumber;


ALTER TABLE Tbl_Patients
ADD PatientIdNumber VARCHAR(250) NULL;




EXEC Prc_PersonalData 
@OPERATION ='GENERATEID'

SELECT PatientIdNumber,* FROM  Tbl_Patients


UPDATE Tbl_Patients
SET PatientIdNumber = 'PTN-00000000005' 
WHERE PatientId ='F20BE3C7-0FC7-45C2-8C35-FF4E0409A139'


/*------------------------------------------------ */
/*---------------- FOR DROP DOWN ---------------- */
/*------------------------------------------------ */



/*---------------- 1. FollowUpReason Lookup Table ---------------- */


CREATE TABLE Lkp_FollowUpReason (
    FollowUpReasonID INT IDENTITY(1,1) PRIMARY KEY,
    FollowUpReason NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_FollowUpReason (FollowUpReason)
VALUES
('Post-surgery check-up'),
('Chronic condition monitoring'),
('Medication adjustment'),
('Lab test review'),
('Therapy progress evaluation'),
('New symptom follow-up'),
('Annual physical review'),
('Specialist referral follow-up');


/*---------------- 2. SymptomsChange ---------------- */


CREATE TABLE Lkp_SymptomsChange (
    SymptomsChangeID INT IDENTITY(1,1) PRIMARY KEY,
    SymptomsChange NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_SymptomsChange (SymptomsChange)
VALUES
('Improved mobility'),
('Reduced pain'),
('No change in symptoms'),
('Increased fatigue'),
('Worsened breathing'),
('Better mood'),
('Headache resolved'),
('Swelling reduced');


/*---------------- 3. PrescribedMedications ---------------- */

CREATE TABLE Lkp_PrescribedMedications (
    MedicationID INT IDENTITY(1,1) PRIMARY KEY,
    Medication NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_PrescribedMedications (Medication)
VALUES
('Ibuprofen 400mg as needed'),
('Metformin 500mg twice daily'),
('Amlodipine 5mg daily'),
('Salbutamol inhaler'),
('Paracetamol 500mg every 6 hours'),
('Cetirizine at night'),
('No medications prescribed');




/*---------------- 4. TestsOrdered ---------------- */

CREATE TABLE Lkp_TestsOrdered (
    TestID INT IDENTITY(1,1) PRIMARY KEY,
    TestName NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_TestsOrdered (TestName)
VALUES
('Blood test'),
('Chest X-ray'),
('MRI Brain'),
('CT Scan Abdomen'),
('Spirometry'),
('Ultrasound Pelvis'),
('ECG - Electrocardiogram'),
('None');


/*---------------- 5. TreatmentResponse ---------------- */


CREATE TABLE Lkp_TreatmentResponse (
    ResponseID INT IDENTITY(1,1) PRIMARY KEY,
    TreatmentResponse NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_TreatmentResponse (TreatmentResponse)
VALUES
('Significant improvement'),
('Partial improvement'),
('No improvement'),
('Symptoms worsened'),
('Stable condition'),
('Resolved completely');



/*---------------- 6. SideEffectsReported ---------------- */


CREATE TABLE Lkp_SideEffectsReported (
    SideEffectID INT IDENTITY(1,1) PRIMARY KEY,
    SideEffect NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_SideEffectsReported (SideEffect)
VALUES
('Mild dizziness'),
('Nausea'),
('Dry mouth'),
('Fatigue'),
('Stomach irritation'),
('Rash'),
('No side effects reported');


/*---------------- 7. LifestyleChangesSuggested ---------------- */


CREATE TABLE Lkp_LifestyleChanges (
    LifestyleChangeID INT IDENTITY(1,1) PRIMARY KEY,
    LifestyleChange NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_LifestyleChanges (LifestyleChange)
VALUES
('Low-sodium diet'),
('High-protein diet'),
('Daily exercise'),
('Avoid caffeine'),
('Mindfulness meditation'),
('Quit smoking'),
('Increase hydration');


/*---------------- 8. ReferralMade ---------------- */


CREATE TABLE Lkp_ReferralMade (
    ReferralID INT IDENTITY(1,1) PRIMARY KEY,
    Referral NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_ReferralMade (Referral)
VALUES
('Physiotherapist'),
('Pulmonologist'),
('Cardiologist'),
('Psychologist'),
('Endocrinologist'),
('Orthopedic surgeon'),
('None');



/*---------------- 9. ChronicConditionStatus ---------------- */

CREATE TABLE Lkp_ChronicConditionStatus (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    Status NVARCHAR(255) NOT NULL
);

INSERT INTO Lkp_ChronicConditionStatus (Status)
VALUES
('Stable'),
('Improving'),
('Deteriorating'),
('Under control'),
('Newly diagnosed'),
('In remission');


/*---------------- 10. RequiresDiagnosticCheck ---------------- */

CREATE TABLE Lkp_RequiresDiagnosticCheck (
    RequiresCheckID INT IDENTITY(1,1) PRIMARY KEY,
    RequiresCheck NVARCHAR(10) NOT NULL
);

INSERT INTO Lkp_RequiresDiagnosticCheck (RequiresCheck)
VALUES
('Yes'),
('No');


/*---------------- 11. DiagnosticCheckDetails ---------------- */


CREATE TABLE Lkp_DiagnosticCheckDetails (
    DiagnosticID INT IDENTITY(1,1) PRIMARY KEY,
    DiagnosticCheckDetails NVARCHAR(255) NULL
);

INSERT INTO Lkp_DiagnosticCheckDetails (DiagnosticCheckDetails)
VALUES
('X-ray (Chest)'),
('MRI Brain'),
('Blood Test'),
('ICG - Heart Check'),
('Ultrasound Abdomen'),
('CT Scan (Head)'),
('Urinalysis'),
('ECG - Electrocardiogram'),
('Liver Function Test'),
('Spirometry - Lung Function'),
('Mammogram'),
('Allergy Skin Test'),
('Colonoscopy'),
('Eye Examination - Fundoscopy'),
(NULL);



EXEC dbo.Prc_PersonalData @Operation = 'GETALL';



SELECT * FROM Tbl_Patients
SELECT * FROM Tbl_PatientConsultations


SELECT SPECIFIC_SCHEMA, ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE = 'PROCEDURE'
AND ROUTINE_NAME = 'Prc_PersonalData';

