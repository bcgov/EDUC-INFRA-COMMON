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
  USUAL_FIRST_NAME VARCHAR2(40),
  USUAL_MIDDLE_NAMES VARCHAR2(255),
  USUAL_LAST_NAME VARCHAR2(40),
  EMAIL VARCHAR2(255),
  DECEASED_DATE DATE,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT STUDENT_PK PRIMARY KEY (STUDENT_ID)  
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
  USUAL_FIRST_NAME VARCHAR2(40),
  USUAL_MIDDLE_NAMES VARCHAR2(255),
  USUAL_LAST_NAME VARCHAR2(40),
  EMAIL VARCHAR2(255) NOT NULL,
  MAIDEN_NAME VARCHAR2(40),
  PAST_NAMES VARCHAR2(255),
  LAST_BC_SCHOOL VARCHAR2(255),
  BCSC_AUTO_MATCH_OUTCOME VARCHAR2(255),
  BCSC_AUTO_MATCH_DETAIL VARCHAR2(255),
  LAST_BC_SCHOOL_STUDENT_NUMBER VARCHAR2(12),
  CURRENT_SCHOOL VARCHAR2(255),
  REVIEWER VARCHAR2(255),
  INITIAL_SUBMIT_DATE DATE,
  STATUS_UPDATE_DATE DATE,
  FAILURE_REASON VARCHAR2(4000),
  EMAIL_VERIFIED VARCHAR2(1) NOT NULL,
  PEN VARCHAR2(9),
  DEMOG_CHANGED VARCHAR2(1),
  COMPLETE_COMMENT VARCHAR2(4000),
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PEN_RETRIEVAL_REQUEST_PK PRIMARY KEY (PEN_RETRIEVAL_REQUEST_ID)  
);

CREATE TABLE STUDENT.PEN_RETRIEVAL_REQUEST_MACRO (
  PEN_RETRIEVAL_REQUEST_MACRO_ID RAW(16) NOT NULL,
  MACRO_CODE VARCHAR2(10) NOT NULL,
  MACRO_TEXT VARCHAR2(4000) NOT NULL,
  MACRO_TYPE_CODE VARCHAR2(10) NOT NULL,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PEN_RETRIEVAL_REQUEST_MACRO_PK PRIMARY KEY (PEN_RETRIEVAL_REQUEST_MACRO_ID)
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

CREATE TABLE STUDENT.STUDENT_GENDER_CODE (
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
  CONSTRAINT STUDENT_GENDER_CODE_PK PRIMARY KEY (GENDER_CODE)  
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

CREATE TABLE STUDENT.STUDENT_SEX_CODE (
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
  CONSTRAINT STUDENT_SEX_CODE_PK PRIMARY KEY (SEX_CODE)  
);

CREATE TABLE STUDENT.PEN_RETRIEVAL_REQUEST_GENDER_CODE (
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
  CONSTRAINT PEN_RETRIEVAL_REQUEST_GENDER_CODE_PK PRIMARY KEY (GENDER_CODE)  
);

CREATE TABLE STUDENT.PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE  (
  PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE_PK PRIMARY KEY (PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE)
);

--Unique constraints
ALTER TABLE STUDENT.DIGITAL_IDENTITY ADD CONSTRAINT UQ_DIGITAL_ID_USER_VAL_TYPE UNIQUE(IDENTITY_TYPE_CODE, IDENTITY_VALUE);
ALTER TABLE STUDENT.PEN_RETRIEVAL_REQUEST_MACRO ADD CONSTRAINT UQ_REQUEST_MACRO_ID_CODE_TYPE UNIQUE(MACRO_CODE, MACRO_TYPE_CODE);

--Foreign key constraints
alter table STUDENT.STUDENT add constraint FK_STUDENT_STUDENT_GENDER_CODE foreign key (GENDER_CODE) references STUDENT.STUDENT_GENDER_CODE (GENDER_CODE);
alter table STUDENT.STUDENT add constraint FK_STUDENT_STUDENT_SEX_CODE foreign key (SEX_CODE) references STUDENT.STUDENT_SEX_CODE (SEX_CODE);

alter table STUDENT.DIGITAL_IDENTITY add constraint FK_DIGITAL_IDENT_IDENT_TYPE_CODE foreign key (IDENTITY_TYPE_CODE) references STUDENT.IDENTITY_TYPE_CODE (IDENTITY_TYPE_CODE);
alter table STUDENT.DIGITAL_IDENTITY add constraint FK_DIGITAL_IDENT_ACCESS_CHAN_CODE foreign key (LAST_ACCESS_CHANNEL_CODE) references STUDENT.ACCESS_CHANNEL_CODE (ACCESS_CHANNEL_CODE);

alter table STUDENT.PEN_RETRIEVAL_REQUEST add constraint FK_PEN_RETRIEVAL_REQUEST_PEN_RETRIEVAL_REQUEST_STATUS_CODE foreign key (PEN_RETRIEVAL_REQUEST_STATUS_CODE) references STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE);
alter table STUDENT.PEN_RETRIEVAL_REQUEST add constraint FK_PEN_RETRIEVAL_REQUEST_PEN_RETRIEVAL_REQUEST_GENDER_CODE foreign key (GENDER_CODE) references STUDENT.PEN_RETRIEVAL_REQUEST_GENDER_CODE (GENDER_CODE);


-- Table Comments
COMMENT ON TABLE Student.Student IS 'Student contains core identifying data for students, include PEN, names, DOB, sex, etc.';
COMMENT ON TABLE Student.Digital_Identity IS 'A Digital Identity is used by a specific student to access Education services. Types of digital identities supported include BC Services Card and Basic BCeID.';
COMMENT ON TABLE Student.PEN_Retrieval_Request IS 'PEN Retrieval Request is a transaction record of a request by a student to retrieve their PEN.';

COMMENT ON TABLE Student.Access_Channel_Code IS 'Access Channel Code lists the various channels (applications or services) that make use of the student Digital Identity records to access Education Services. Examples are the Online Student PEN Retrieval and the Student Transcript Service.';
COMMENT ON TABLE Student.STUDENT_Gender_Code IS 'Gender Code lists the standard codes for Gender: Female, Male, Diverse.';
COMMENT ON TABLE Student.PEN_RETRIEVAL_REQUEST_Gender_Code IS 'Gender Code lists the standard codes for Gender: Female, Male, Diverse.';
COMMENT ON TABLE Student.Identity_Type_Code IS 'Identity Type Code lists the types of digital identities supported. Examples are BC Services Card and Basic BCeID.';
COMMENT ON TABLE Student.PEN_Retrieval_Request_Status_Code IS 'PEN Retrieval Request Status Code lists the transaction status values for the PEN Retrieval Requests. Examples are Submitted, Pending Student Input, Completed, Rejected.';
COMMENT ON TABLE Student.student_Sex_Code IS 'Sex Code lists the standard codes for Sex: Female, Male, Intersex.';
COMMENT ON TABLE STUDENT.PEN_RETRIEVAL_REQUEST_MACRO IS 'List of text macros used as standard messages by PEN Staff when completing PEN Retrieval Requests.';
COMMENT ON TABLE STUDENT.PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE IS 'Macro Type Code indicates the supported types of text macros.';


-- Column Comments
COMMENT ON COLUMN STUDENT.Student.Student_ID IS 'Unique surrogate key for each Student. GUID value must be provided during insert.';
COMMENT ON COLUMN STUDENT.Student.PEN IS 'Provincial Education Number assigned by system to this student, in SIN format; used to track a student all through their educational career. ';
COMMENT ON COLUMN STUDENT.Student.Legal_First_Name IS 'The legal first name of the student';
COMMENT ON COLUMN STUDENT.Student.Legal_Middle_Names IS 'The legal middle names of the student';
COMMENT ON COLUMN STUDENT.Student.Legal_Last_Name IS 'The legal last name of the student';
COMMENT ON COLUMN STUDENT.Student.DOB IS 'The date of birth of the student';
COMMENT ON COLUMN STUDENT.Student.Sex_Code IS 'The sex of the student';
COMMENT ON COLUMN STUDENT.Student.Gender_Code IS 'The gender of the student';
COMMENT ON COLUMN STUDENT.Student.Usual_First_Name IS 'The usual/preferred first name of the student';
COMMENT ON COLUMN STUDENT.Student.Usual_Middle_Names IS 'The usual/preferred middle name of the student';
COMMENT ON COLUMN STUDENT.Student.Usual_Last_Name IS 'The usual/preferred last name of the student';
COMMENT ON COLUMN STUDENT.Student.Email IS 'The email address of the student';
COMMENT ON COLUMN STUDENT.Student.Deceased_Date IS 'The date of death for the student. Will be known to EDUC only if student was an active student at the time.';

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
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.BCSC_Auto_Match_Outcome IS 'Short value indicating the outcome of performing the BCSC AutoMatch search. Values NOMATCH, ONEMATCH, MANYMATCHES, RIGHTPEN, WRONGPEN, null.';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.BCSC_Auto_Match_Detail IS 'Description providing more info about outcome of performing the BCSC AutoMatch search. When the search returned one result, this will hold the PEN and Legal Names of the the record matched.';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.PEN IS 'The PEN value that was matched to this PEN Request, either manually by staff or automatically by the system.';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.EMAIL_VERIFIED IS 'Short value indicating whether the email of the student has been verified.';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.DEMOG_CHANGED IS 'Short value indicating whether the demographic information reported to PEN has been updated when completing PEN Retrieval Requests.';
COMMENT ON COLUMN STUDENT.PEN_Retrieval_Request.COMPLETE_COMMENT IS 'Free text message entered by PEN Staff when completing PEN Retrieval Requests.';

COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_MACRO.MACRO_CODE IS 'A short text string that identifies the macro and when identified will be replaced by the macro text.';
COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_MACRO.MACRO_TEXT IS 'A standard text string that will be substituted for the macro code by the application.';
COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_MACRO.MACRO_TYPE_CODE IS 'A code value indicating the type, or class, of the text macro.';

-- Table PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE
CREATE TABLE STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (
  PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE VARCHAR2(10) NOT NULL,
  LABEL VARCHAR2(30),
  DESCRIPTION VARCHAR2(255),
  DISPLAY_ORDER NUMBER DEFAULT 1 NOT NULL,
  EFFECTIVE_DATE DATE NOT NULL,
  EXPIRY_DATE DATE NOT NULL,  
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE_PK PRIMARY KEY (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE)  
);

COMMENT ON TABLE STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE IS 'PEN Retrieval Request Document Type Code lists the semantic types of documents that are supported. Examples include Birth Certificate (image of), Passport image, Permanent Resident Card image, etc.';

-- Table PEN_RETRIEVAL_REQUEST_DOCUMENT
CREATE TABLE STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT (
  PEN_RETRIEVAL_REQUEST_DOCUMENT_ID RAW(16) NOT NULL,
  PEN_RETRIEVAL_REQUEST_ID RAW(16) NOT NULL, 
  PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE VARCHAR2(10) NOT NULL,
  FILE_NAME VARCHAR2(255) NOT NULL,
  FILE_EXTENSION VARCHAR2(255),
  FILE_SIZE NUMBER,
  DOCUMENT_DATA BLOB NOT NULL,
  CREATE_USER VARCHAR2(32) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  UPDATE_USER VARCHAR2(32) NOT NULL,
  UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  CONSTRAINT STUDENT_DOCUMENT_PK PRIMARY KEY (PEN_RETRIEVAL_REQUEST_DOCUMENT_ID)  
)
TABLESPACE STUDENT_BLOB_DATA
;  

COMMENT ON TABLE STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT IS 'Holds documents related to Students, either directly or indirectly.';

COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_ID IS 'Unique surrogate primary key for each Student Document. GUID value must be provided during insert.';
COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT.PEN_RETRIEVAL_REQUEST_ID IS 'Foreign key to the PEN Retrieval Request.';
COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE IS 'Code indicating the type of the semantic type of the document. E.g. Birth Certificate, Passport, etc.';
COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT.FILE_NAME IS 'Name of the document file, without any local file path.';
COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT.FILE_EXTENSION IS 'Extension portion of the filename, if present. E.g. JPG, PNG, PDF, etc.';
COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT.FILE_SIZE IS 'Size of the file in bytes, if known.';
COMMENT ON COLUMN STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT.DOCUMENT_DATA IS 'Binary representation of the file contents.';

alter table STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT add constraint FK_PEN_RETRIEVAL_REQUEST_DOCUMENT_PEN_RETRIEVAL_REQUEST_ID foreign key (PEN_RETRIEVAL_REQUEST_ID) references STUDENT.PEN_RETRIEVAL_REQUEST (PEN_RETRIEVAL_REQUEST_ID);
alter table STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT add constraint FK_PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE foreign key (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE) references STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE);

-- Table PEN_RETRIEVAL_REQUEST_COMMENT
CREATE TABLE STUDENT.PEN_RETRIEVAL_REQUEST_COMMENT 
(	
   PEN_RETRIEVAL_REQUEST_COMMENT_ID RAW(16) NOT NULL, 
   PEN_RETRIEVAL_REQUEST_ID RAW(16) NOT NULL, 
   STAFF_MEMBER_IDIR_GUID RAW(16), 
   STAFF_MEMBER_NAME VARCHAR2(255), 
   COMMENT_CONTENT VARCHAR2(4000), 
   COMMENT_TIMESTAMP DATE, 
   CREATE_USER VARCHAR2(32) NOT NULL, 
   CREATE_DATE DATE DEFAULT SYSDATE NOT NULL, 
   UPDATE_USER VARCHAR2(32) NOT NULL, 
   UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL, 
   CONSTRAINT PEN_RETRIEVAL_REQUEST_COMMENT_PK PRIMARY KEY (PEN_RETRIEVAL_REQUEST_COMMENT_ID)
);
alter table STUDENT.PEN_RETRIEVAL_REQUEST_COMMENT add constraint FK_PEN_RETRIEVAL_REQUEST_COMMENT_PEN_RETRIEVAL_REQUEST_ID foreign key (PEN_RETRIEVAL_REQUEST_ID) references STUDENT.PEN_RETRIEVAL_REQUEST (PEN_RETRIEVAL_REQUEST_ID);

CREATE TABLE STUDENT.SERVICES_CARD_INFO 
(	
   SERVICES_CARD_INFO_ID RAW(16) NOT NULL, 
   DIGITAL_IDENTITY_ID RAW(16) NOT NULL, 
   DID VARCHAR2(255) NOT NULL, 
   USER_DISPLAY_NAME VARCHAR2(255), 
   GIVEN_NAME VARCHAR2(255),
   GIVEN_NAMES VARCHAR2(255),
   SURNAME VARCHAR2(255) NOT NULL,
   BIRTHDATE DATE NOT NULL,
   GENDER VARCHAR2(7) NOT NULL,
   EMAIL VARCHAR2(255),
   STREET_ADDRESS VARCHAR2(1000) NOT NULL,
   CITY VARCHAR2(255) NOT NULL,
   PROVINCE VARCHAR2(255) NOT NULL,
   COUNTRY VARCHAR2(255) NOT NULL,
   POSTAL_CODE VARCHAR2(7) NOT NULL,
   IDENTITY_ASSURANCE_LEVEL VARCHAR2(1) NOT NULL,
   CREATE_USER VARCHAR2(32) NOT NULL, 
   CREATE_DATE DATE DEFAULT SYSDATE NOT NULL, 
   UPDATE_USER VARCHAR2(32) NOT NULL, 
   UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL, 
   CONSTRAINT SERVICES_CARD_IDENTITY_PK PRIMARY KEY (SERVICES_CARD_INFO_ID)
);

CREATE OR REPLACE EDITIONABLE SYNONYM "STUDENT"."PEN_DEMOG" FOR "PEN_DEMOG"@"PENLINK.WORLD";

--Grants for PROXY users:
--Services Card Proxy
GRANT SELECT, INSERT, UPDATE, DELETE ON SERVICES_CARD_INFO TO PROXY_SERVICES_CARD;

--Digital ID Proxy
GRANT SELECT, INSERT, UPDATE, DELETE ON DIGITAL_IDENTITY TO PROXY_DIGITAL_ID;
GRANT SELECT, INSERT, UPDATE, DELETE ON ACCESS_CHANNEL_CODE TO PROXY_DIGITAL_ID;
GRANT SELECT, INSERT, UPDATE, DELETE ON IDENTITY_TYPE_CODE TO PROXY_DIGITAL_ID;

--Student Proxy
GRANT SELECT, INSERT, UPDATE, DELETE ON STUDENT TO PROXY_STUDENT;
GRANT SELECT, INSERT, UPDATE, DELETE ON STUDENT_GENDER_CODE TO PROXY_STUDENT;
GRANT SELECT, INSERT, UPDATE, DELETE ON STUDENT_SEX_CODE TO PROXY_STUDENT;

--PEN Retrieval Proxy
GRANT SELECT, INSERT, UPDATE, DELETE ON PEN_RETRIEVAL_REQUEST TO PROXY_PEN_RETRIEVAL;
GRANT SELECT, INSERT, UPDATE, DELETE ON PEN_RETRIEVAL_REQUEST_COMMENT TO PROXY_PEN_RETRIEVAL;
GRANT SELECT, INSERT, UPDATE, DELETE ON PEN_RETRIEVAL_REQUEST_DOCUMENT TO PROXY_PEN_RETRIEVAL;
GRANT SELECT, INSERT, UPDATE, DELETE ON PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE TO PROXY_PEN_RETRIEVAL;
GRANT SELECT, INSERT, UPDATE, DELETE ON PEN_RETRIEVAL_REQUEST_GENDER_CODE TO PROXY_PEN_RETRIEVAL;
GRANT SELECT, INSERT, UPDATE, DELETE ON PEN_RETRIEVAL_REQUEST_STATUS_CODE TO PROXY_PEN_RETRIEVAL;
GRANT SELECT, INSERT, UPDATE, DELETE ON PEN_RETRIEVAL_REQUEST_MACRO TO PROXY_PEN_RETRIEVAL;
GRANT SELECT, INSERT, UPDATE, DELETE ON PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE TO PROXY_PEN_RETRIEVAL;

--Indexes for commonly queried columns
create index digital_identity_identity_value_i on STUDENT.digital_identity ( identity_value );
create index pen_retrieval_request_digital_identity_id_i on STUDENT.pen_retrieval_request ( digital_identity_id );
create index pen_retrieval_request_comment_pen_retrieval_request_id_i on STUDENT.pen_retrieval_request_comment ( pen_retrieval_request_id );
create index pen_retrieval_request_document_pen_retrieval_request_id_i on STUDENT.pen_retrieval_request_document ( pen_retrieval_request_id );
create index services_card_info_did_i on STUDENT.services_card_info ( did );
