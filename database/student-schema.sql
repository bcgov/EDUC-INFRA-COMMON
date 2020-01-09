--Users
--Student
CREATE USER STUDENT IDENTIFIED BY &mypassword;
GRANT create session TO STUDENT;
GRANT create table TO STUDENT;
GRANT create view TO STUDENT;
GRANT create trigger TO STUDENT;
GRANT create procedure TO STUDENT;
GRANT create sequence TO STUDENT;
GRANT create synonym TO STUDENT;

ALTER USER STUDENT QUOTA UNLIMITED ON USERS;

--STUDENT_PROXY
CREATE USER STUDENT_PROXY IDENTIFIED BY &mypassword;
GRANT create session TO STUDENT_PROXY;
ALTER USER STUDENT_PROXY QUOTA UNLIMITED ON USERS;

--Tables
CREATE TABLE STUDENT.STUDENT ( 
  STUDENT_ID RAW(16) NOT NULL,  
  PEN VARCHAR2(9) NOT NULL CONSTRAINT PEN_UNIQUE UNIQUE,  
  LEGAL_FIRST_NAME VARCHAR2(40),
  LEGAL_MIDDLE_NAMES VARCHAR2(255),
  LEGAL_LAST_NAME VARCHAR2(40) NOT NULL,
  DOB DATE NOT NULL,
  SEX_CODE VARCHAR2(1),
  GENDER_CODE VARCHAR2(1),
  DATA_SOURCE_CODE VARCHAR2(10) NOT NULL,
  USUAL_FIRST_NAME VARCHAR2(40),
  USUAL_MIDDLE_NAMES VARCHAR2(255),
  USUAL_LAST_NAME VARCHAR2(40),
  EMAIL VARCHAR2(255) CONSTRAINT STUDENT_EMAIL_UNIQUE UNIQUE,
  DECEASED_DATE DATE,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT STUDENT_PK PRIMARY KEY (STUDENT_ID)  
);  

CREATE TABLE STUDENT.ADDRESS (
  ADDRESS_ID RAW(16) NOT NULL,  
  STUDENT_ID RAW(16) NOT NULL,  
  ADDRESS_TYPE_CODE VARCHAR2(10) NOT NULL,
  ADDRESS_LINE_1 VARCHAR2(255),
  ADDRESS_LINE_2 VARCHAR2(255),
  CITY VARCHAR2(50),
  PROVINCE_CODE VARCHAR2(2),
  COUNTRY_CODE VARCHAR2(3),
  POSTAL_CODE VARCHAR2(7),
  DATA_SOURCE_CODE VARCHAR2(10) NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT ADDRESS_PK PRIMARY KEY (ADDRESS_ID)  
);

CREATE TABLE STUDENT.DIGITAL_IDENTITY (
  DIGITAL_IDENTITY_ID RAW(16) NOT NULL,  
  STUDENT_ID RAW(16),
  IDENTITY_TYPE_CODE VARCHAR2(10) NOT NULL,
  IDENTITY_VALUE VARCHAR2(255) NOT NULL,
  LAST_ACCESS_DATE DATE NOT NULL,
  LAST_ACCESS_CHANNEL_CODE VARCHAR2(10) NOT NULL,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT DIGITAL_IDENTITY_PK PRIMARY KEY (DIGITAL_IDENTITY_ID)  
);

CREATE TABLE STUDENT.PEN_RETRIEVAL_REQUEST (
  PEN_RETRIEVAL_REQUEST_ID RAW(16) NOT NULL,
  DIGITAL_IDENTITY_ID RAW(16) NOT NULL,
  PEN_RETRIEVAL_REQUEST_STATUS_CODE VARCHAR2(10) NOT NULL,
  LEGAL_FIRST_NAME VARCHAR2(40),
  LEGAL_MIDDLE_NAMES VARCHAR2(255),
  LEGAL_LAST_NAME VARCHAR2(40) NOT NULL,
  DOB DATE NOT NULL,
  GENDER_CODE VARCHAR2(1) NOT NULL,
  DATA_SOURCE_CODE VARCHAR2(10) NOT NULL,
  USUAL_FIRST_NAME VARCHAR2(40),
  USUAL_MIDDLE_NAMES VARCHAR2(255),
  USUAL_LAST_NAME VARCHAR2(40),
  EMAIL VARCHAR2(255) NOT NULL,
  MAIDEN_NAME VARCHAR2(40),
  PAST_NAMES VARCHAR2(255),
  LAST_BC_SCHOOL VARCHAR2(255),
  LAST_BC_SCHOOL_STUDENT_NUMBER VARCHAR2(12),
  CURRENT_SCHOOL VARCHAR2(255),
  REVIEWER VARCHAR2(255),
  INITIAL_SUBMIT_DATE DATE,
  STATUS_UPDATE_DATE DATE,
  FAILURE_REASON VARCHAR2(4000),
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PEN_RETRIEVAL_REQUEST_PK PRIMARY KEY (PEN_RETRIEVAL_REQUEST_ID)  
);

-- Lookup Code Tables
CREATE TABLE STUDENT.ACCESS_CHANNEL_CODE (
  ACCESS_CHANNEL_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT ACCESS_CHANNEL_CODE_PK PRIMARY KEY (ACCESS_CHANNEL_CODE)  
);

CREATE TABLE STUDENT.ADDRESS_TYPE_CODE (
  ADDRESS_TYPE_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT ADDRESS_TYPE_CODE_PK PRIMARY KEY (ADDRESS_TYPE_CODE)  
);

CREATE TABLE STUDENT.DATA_SOURCE_CODE (
  DATA_SOURCE_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT DATA_SOURCE_CODE_PK PRIMARY KEY (DATA_SOURCE_CODE)  
);

CREATE TABLE STUDENT.GENDER_CODE (
  GENDER_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT GENDER_CODE_PK PRIMARY KEY (GENDER_CODE)  
);

CREATE TABLE STUDENT.IDENTITY_TYPE_CODE (
  IDENTITY_TYPE_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT IDENTITY_TYPE_CODE_PK PRIMARY KEY (IDENTITY_TYPE_CODE)  
);

CREATE TABLE STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (
  PEN_RETRIEVAL_REQUEST_STATUS_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PEN_RETRIEVAL_REQUEST_STATUS_CODE_PK PRIMARY KEY (PEN_RETRIEVAL_REQUEST_STATUS_CODE)  
);

CREATE TABLE STUDENT.SEX_CODE (
  SEX_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT SEX_CODE_PK PRIMARY KEY (SEX_CODE)  
);

--Unique constraints
ALTER TABLE STUDENT.DIGITAL_IDENTITY ADD CONSTRAINT UQ_DIGITAL_ID_USER_VAL_TYPE UNIQUE(IDENTITY_TYPE_CODE, IDENTITY_VALUE);

--Foreign key constraints
alter table STUDENT.STUDENT add constraint FK_STUDENT_GENDER_CODE foreign key (GENDER_CODE) references STUDENT.GENDER_CODE (GENDER_CODE);
alter table STUDENT.STUDENT add constraint FK_STUDENT_SEX_CODE foreign key (SEX_CODE) references STUDENT.SEX_CODE (SEX_CODE);
alter table STUDENT.STUDENT add constraint FK_STUDENT_DATA_SOURCE_CODE foreign key (DATA_SOURCE_CODE) references STUDENT.DATA_SOURCE_CODE (DATA_SOURCE_CODE);

alter table STUDENT.ADDRESS add constraint FK_ADDRESS_STUDENT_ID foreign key (STUDENT_ID) references STUDENT.STUDENT (STUDENT_ID);
alter table STUDENT.ADDRESS add constraint FK_ADDRESS_DATA_SOURCE_CODE foreign key (DATA_SOURCE_CODE) references STUDENT.DATA_SOURCE_CODE (DATA_SOURCE_CODE);
alter table STUDENT.ADDRESS add constraint FK_ADDRESS_ADDRESS_TYPE_CODE foreign key (ADDRESS_TYPE_CODE) references STUDENT.ADDRESS_TYPE_CODE (ADDRESS_TYPE_CODE);

alter table STUDENT.DIGITAL_IDENTITY add constraint FK_DIGITAL_IDENTITY_STUDENT_ID foreign key (STUDENT_ID) references STUDENT.STUDENT (STUDENT_ID);
alter table STUDENT.DIGITAL_IDENTITY add constraint FK_DIGITAL_IDENT_IDENT_TYPE_CODE foreign key (IDENTITY_TYPE_CODE) references STUDENT.IDENTITY_TYPE_CODE (IDENTITY_TYPE_CODE);
alter table STUDENT.DIGITAL_IDENTITY add constraint FK_DIGITAL_IDENT_ACCESS_CHAN_CODE foreign key (LAST_ACCESS_CHANNEL_CODE) references STUDENT.ACCESS_CHANNEL_CODE (ACCESS_CHANNEL_CODE);

alter table STUDENT.PEN_RETRIEVAL_REQUEST add constraint FK_PEN_RETRIEVAL_REQUEST_DIGITAL_IDENTITY_ID foreign key (DIGITAL_IDENTITY_ID) references STUDENT.DIGITAL_IDENTITY (DIGITAL_IDENTITY_ID);
alter table STUDENT.PEN_RETRIEVAL_REQUEST add constraint FK_PEN_RETRIEVAL_REQUEST_PEN_RETRIEVAL_REQUEST_STATUS_CODE foreign key (PEN_RETRIEVAL_REQUEST_STATUS_CODE) references STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE);
alter table STUDENT.PEN_RETRIEVAL_REQUEST add constraint FK_PEN_RETRIEVAL_REQUEST_DATA_SOURCE_CODE foreign key (DATA_SOURCE_CODE) references STUDENT.DATA_SOURCE_CODE (DATA_SOURCE_CODE);
alter table STUDENT.PEN_RETRIEVAL_REQUEST add constraint FK_PEN_RETRIEVAL_REQUEST_GENDER_CODE foreign key (GENDER_CODE) references STUDENT.GENDER_CODE (GENDER_CODE);


-- Table Comments
COMMENT ON TABLE Student.Student IS 'Student contains core identifying data for students, include PEN, names, DOB, sex, etc.';
COMMENT ON TABLE Student.Digital_Identity IS 'A Digital Identity is used by a specific student to access Education services. Types of digital identities supported include BC Services Card and Basic BCeID.';
COMMENT ON TABLE Student.PEN_Retrieval_Request IS 'PEN Retrieval Request is a transaction record of a request by a student to retrieve their PEN.';
COMMENT ON TABLE Student.Address IS 'Address holds address information for students.';

COMMENT ON TABLE Student.Access_Channel_Code IS 'Access Channel Code lists the various channels (applications or services) that make use of the student Digital Identity records to access Education Services. Examples are the Online Student PEN Retrieval and the Student Transcript Service.';
COMMENT ON TABLE Student.Address_Type_Code IS 'Address Type Code lists the types of addresses. Examples are Mailing, Physical, and Delivery.';
COMMENT ON TABLE Student.Data_Source_Code IS 'Data Source Code lists the sources for student data. Examples are BC Services Card, MyEducation BC, Birth Certificate.';
COMMENT ON TABLE Student.Gender_Code IS 'Gender Code lists the standard codes for Gender: Female, Male, Diverse.';
COMMENT ON TABLE Student.Identity_Type_Code IS 'Identity Type Code lists the types of digital identities supported. Examples are BC Services Card and Basic BCeID.';
COMMENT ON TABLE Student.PEN_Retrieval_Request_Status_Code IS 'PEN Retrieval Request Status Code lists the transaction status values for the PEN Retrieval Requests. Examples are Submitted, Pending Student Input, Completed, Rejected.';
COMMENT ON TABLE Student.Sex_Code IS 'Sex Code lists the standard codes for Sex: Female, Male, Intersex.';


-- Column Comments
COMMENT ON COLUMN STUDENT.Student.Student_ID IS 'Unique surrogate key for each Student. GUID value must be provided during insert.';
COMMENT ON COLUMN STUDENT.Student.PEN IS 'Provincial Education Number assigned by system to this student, in SIN format; used to track a student all through their educational career. ';
COMMENT ON COLUMN STUDENT.Student.Legal_First_Name IS 'The legal first name of the student';
COMMENT ON COLUMN STUDENT.Student.Legal_Middle_Names IS 'The legal middle names of the student';
COMMENT ON COLUMN STUDENT.Student.Legal_Last_Name IS 'The legal last name of the student';
COMMENT ON COLUMN STUDENT.Student.DOB IS 'The date of birth of the student';
COMMENT ON COLUMN STUDENT.Student.Sex_Code IS 'The sex of the student';
COMMENT ON COLUMN STUDENT.Student.Gender_Code IS 'The gender of the student';
COMMENT ON COLUMN STUDENT.Student.Data_Source_Code IS 'Code indicating the primary data source for the Student data';
COMMENT ON COLUMN STUDENT.Student.Usual_First_Name IS 'The usual/preferred first name of the student';
COMMENT ON COLUMN STUDENT.Student.Usual_Middle_Names IS 'The usual/preferred middle name of the student';
COMMENT ON COLUMN STUDENT.Student.Usual_Last_Name IS 'The usual/preferred last name of the student';
COMMENT ON COLUMN STUDENT.Student.Email IS 'The email address of the student';
COMMENT ON COLUMN STUDENT.Student.Deceased_Date IS 'The date of death for the student. Will be known to EDUC only if student was an active student at the time.';

COMMENT ON COLUMN STUDENT.Address.Address_ID IS 'Unique surrogate key for each Address. GUID value must be provided during insert.';
COMMENT ON COLUMN STUDENT.Address.Student_ID IS 'Foreign key to Student table identifying Student that is identified by the Digital Identity';
COMMENT ON COLUMN STUDENT.Address.Address_Type_Code IS 'Code indicating the type of the address.';
COMMENT ON COLUMN STUDENT.Address.Address_Line_1 IS 'Line 1 of address';
COMMENT ON COLUMN STUDENT.Address.Address_Line_2 IS 'Line 2 of address';
COMMENT ON COLUMN STUDENT.Address.City IS 'Name of city or municipality for the address';
COMMENT ON COLUMN STUDENT.Address.Province_Code IS 'Province or State as the Canada Post 2 char code';
COMMENT ON COLUMN STUDENT.Address.Country_Code IS 'Country of address, as the ISO 3 char code';
COMMENT ON COLUMN STUDENT.Address.Postal_Code IS 'Postal Code for the address. Format: ANA NAN';
COMMENT ON COLUMN STUDENT.Address.Data_Source_Code IS 'Source of the data for the address';

COMMENT ON COLUMN STUDENT.Digital_Identity.Digital_Identity_ID IS 'Unique surrogate key for each Digital Identity. GUID value must be provided during insert.';
COMMENT ON COLUMN STUDENT.Digital_Identity.Student_ID IS 'Foreign key to Student table identifying Student that is identified by the Digital Identity';
COMMENT ON COLUMN STUDENT.Digital_Identity.Identity_Type_Code IS 'Code indicating the type of the digital identity.';
COMMENT ON COLUMN STUDENT.Digital_Identity.Identity_Value IS 'Value of the digital identifier. May be a string, a GUID, a BCSC DID, etc.';
COMMENT ON COLUMN STUDENT.Digital_Identity.Last_Access_Date IS 'The date and time of the last access to the system based on this digital identity.';
COMMENT ON COLUMN STUDENT.Digital_Identity.Last_Access_Channel_Code IS 'Code indicating the channel or application that this digital identity accessed.';

COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.PEN_Retrieval_Request_ID IS 'Unique surrogate key for each PEN Retrieval request. GUID value must be provided during insert.';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Digital_Identity_ID IS 'Foreign key to Digital Identity table identifying the Digital Identity that is was used to make this request';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.PEN_Retrieval_Request_Status_Code IS 'Code indicating the status of the Student PEN Retrieval request';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Legal_First_Name IS 'The legal first name of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Legal_Middle_Names IS 'The legal middle names of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Legal_Last_Name IS 'The legal last name of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.DOB IS 'The date of birth of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Gender_Code IS 'The gender of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Data_Source_Code IS 'Code indicating the primary data source for the Student data';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Usual_First_Name IS 'The usual/preferred first name of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Usual_Middle_Names IS 'The usual/preferred middle name of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Usual_Last_Name IS 'The usual/preferred last name of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Email IS 'Email of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Maiden_Name IS 'Maiden Name of the student, if applicable';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Past_Names IS 'Past Names of the student';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Last_BC_School IS 'Name of last BC school that the student attended';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Last_BC_School_Student_Number IS 'Student Number assigned to student at the last BC school attended';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Current_School IS 'Name of current BC school, if applicable';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Reviewer IS 'IDIR of the staff user who is working or did work on the PEN Retrieval Request';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Initial_Submit_Date IS 'Date and time that the Student first fully submitted the request, which does not happen until after they submit and verify their email address.';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Status_Update_Date IS 'Date and time that the status of the PEN Retrieval Request was last updated.';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.Failure_Reason IS 'Free text reason for why Min EDUC staff could not complete the request. This is used for both Rejects and Unable to complete failures.';


-- PEN-224 Add tables for Document storage

-- Table DOCUMENT_TYPE_CODE
CREATE TABLE STUDENT.DOCUMENT_TYPE_CODE (
  DOCUMENT_TYPE_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT DOCUMENT_TYPE_CODE_PK PRIMARY KEY (DOCUMENT_TYPE_CODE)  
);

COMMENT ON TABLE Student.Document_Type_Code IS 'Document Type Code lists the semantic types of documents that are supported. Examples include Birth Certificate (image of), Passport image, Permanent Resident Card image, etc.';

GRANT SELECT, INSERT, UPDATE ON STUDENT.DOCUMENT_TYPE_CODE TO STUDENT_PROXY;

-- Table DOCUMENT_OWNER_CODE
CREATE TABLE STUDENT.DOCUMENT_OWNER_CODE (
  DOCUMENT_OWNER_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT DOCUMENT_OWNER_CODE_PK PRIMARY KEY (DOCUMENT_OWNER_CODE)  
);

COMMENT ON TABLE Student.Document_Owner_Code IS 'Document Owner Code identifies which kind of entity owns this document instance. E.g. Student or PEN Retrieval Request.';

GRANT SELECT, INSERT, UPDATE ON STUDENT.DOCUMENT_OWNER_CODE TO STUDENT_PROXY;


-- Table STUDENT_DOCUMENT
CREATE TABLE STUDENT.STUDENT_DOCUMENT (
  STUDENT_DOCUMENT_ID RAW(16) NOT NULL,
  DOCUMENT_TYPE_CODE VARCHAR2(10) NOT NULL,
  FILE_NAME VARCHAR2(255) NOT NULL,
  FILE_EXTENSION VARCHAR2(255),
  FILE_SIZE NUMBER,
  DOCUMENT_DATA BLOB NOT NULL,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT STUDENT_DOCUMENT_PK PRIMARY KEY (STUDENT_DOCUMENT_ID)  
)
TABLESPACE STUDENT_BLOB_DATA
;  

COMMENT ON TABLE Student.Student_Document IS 'Holds documents related to Students, either directly or indirectly.';

COMMENT ON COLUMN Student.Student_Document.Student_Document_ID IS 'Unique surrogate primary key for each Student Document. GUID value must be provided during insert.';
COMMENT ON COLUMN Student.Student_Document.Document_Type_Code IS 'Code indicating the type of the semantic type of the document. E.g. Birth Certificate, Passport, etc.';
COMMENT ON COLUMN Student.Student_Document.File_Name IS 'Name of the document file, without any local file path.';
COMMENT ON COLUMN Student.Student_Document.File_Extension IS 'Extension portion of the filename, if present. E.g. JPG, PNG, PDF, etc.';
COMMENT ON COLUMN Student.Student_Document.File_Size IS 'Size of the file in bytes, if known.';
COMMENT ON COLUMN Student.Student_Document.Document_Data IS 'Binary representation of the file contents.';

alter table STUDENT.STUDENT_DOCUMENT add constraint FK_STUDENT_DOCUMENT_TYPE_CODE foreign key (DOCUMENT_TYPE_CODE) references STUDENT.DOCUMENT_TYPE_CODE (DOCUMENT_TYPE_CODE);

GRANT SELECT, INSERT, UPDATE ON STUDENT.STUDENT_DOCUMENT TO STUDENT_PROXY;

-- Table STUDENT_DOCUMENT_OWNER_XREF
CREATE TABLE STUDENT.STUDENT_DOCUMENT_OWNER_XREF (
  STUDENT_DOCUMENT_ID RAW(16) NOT NULL,
  DOCUMENT_OWNER_TYPE_CODE VARCHAR2(10) NOT NULL,
  DOCUMENT_OWNER_ID RAW(16) NOT NULL,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT STUDENT_DOCUMENT_OWNER_XREF_PK PRIMARY KEY (STUDENT_DOCUMENT_ID,DOCUMENT_OWNER_TYPE_CODE,DOCUMENT_OWNER_ID)  
);  

COMMENT ON TABLE Student.Student_Document_Owner_XREF IS 'Links Student Document records to one or more other entities that are the owner of the document, such as a Student record or a PEN Retrieval Request record.';

COMMENT ON COLUMN Student.Student_Document_Owner_XREF.Student_Document_ID IS 'Foreign key to Student Document table identifying Student Document that is cross-referenced. A GUID.';
COMMENT ON COLUMN Student.Student_Document_Owner_XREF.Document_Owner_Type_Code IS 'Part of Foreign key to referenced document owner. Identifies which class of entity is the owner of the document, such as Student or PEN Retrieval Request.';
COMMENT ON COLUMN Student.Student_Document_Owner_XREF.Document_Owner_ID IS 'Part of Foreign key to referenced document owner. Identifies which exact entity instance is the owner of the record. This is a GUID.';

alter table STUDENT.STUDENT_DOCUMENT_OWNER_XREF add constraint FK_STUDENT_DOCUMENT_ID foreign key (STUDENT_DOCUMENT_ID) references STUDENT.STUDENT_DOCUMENT (STUDENT_DOCUMENT_ID);
-- The second side of the XREF is to one of several tables (identified by DOCUMENT_OWNER_TYPE_CODE), so there is no FK constraint added for it.

CREATE INDEX DOCUMENT_OWNER_IDX ON STUDENT_DOCUMENT_OWNER_XREF
  (DOCUMENT_OWNER_ID ASC);

GRANT SELECT, INSERT, UPDATE ON STUDENT.STUDENT_DOCUMENT_OWNER_XREF TO STUDENT_PROXY;


--Grants for STUDENT_PROXY
GRANT SELECT, INSERT, UPDATE ON STUDENT.STUDENT TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.ADDRESS TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.DIGITAL_IDENTITY TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.PEN_RETRIEVAL_REQUEST TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.ACCESS_CHANNEL_CODE TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.ADDRESS_TYPE_CODE TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.DATA_SOURCE_CODE TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.GENDER_CODE TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.IDENTITY_TYPE_CODE TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE TO STUDENT_PROXY;
GRANT SELECT, INSERT, UPDATE ON STUDENT.SEX_CODE TO STUDENT_PROXY;

