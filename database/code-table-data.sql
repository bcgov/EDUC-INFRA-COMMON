-- Insert data for Student schema code tables

SET DEFINE OFF;

-- Access Channel Code
Insert into STUDENT.ACCESS_CHANNEL_CODE (ACCESS_CHANNEL_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('OSPR','Online Student PEN Retrieval','The Online Student PEN Retrieval (OSPR) application used by Students to get their PEN value. EDUC staff use the app to fulfill retrieval reqeusts.',1,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.ACCESS_CHANNEL_CODE (ACCESS_CHANNEL_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('STS','Student Transcripts Service','The Student Transcript Service that is used by Students to either get a copy of their high-school transcript or to send copies to schools, employers, etc.',2,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));

-- Student Gender Code
Insert into STUDENT.STUDENT_GENDER_CODE (GENDER_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('F','Female','Persons whose current gender is female. This includes cisgender and transgender persons who are female.',1,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.STUDENT_GENDER_CODE (GENDER_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('M','Male','Persons whose current gender is male. This includes cisgender and transgender persons who are male.',2,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.STUDENT_GENDER_CODE (GENDER_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('X','Gender Diverse','Persons whose current gender is not exclusively as male or female. It includes people who do not have one gender, have no gender, are non-binary, or are Two-Spirit.',3,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.STUDENT_GENDER_CODE (GENDER_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('U','Unknown','Persons whose gender is not known at the time of data collection. It may or may not get updated at a later point in time. X is different than U.',4,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));

-- PEN Request Gender Code
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_GENDER_CODE (GENDER_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('F','Female','Persons whose current gender is female. This includes cisgender and transgender persons who are female.',1,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_GENDER_CODE (GENDER_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('M','Male','Persons whose current gender is male. This includes cisgender and transgender persons who are male.',2,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_GENDER_CODE (GENDER_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('X','Gender Diverse','Persons whose current gender is not exclusively as male or female. It includes people who do not have one gender, have no gender, are non-binary, or are Two-Spirit.',3,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_GENDER_CODE (GENDER_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('U','Unknown','Persons whose gender is not known at the time of data collection. It may or may not get updated at a later point in time. X is different than U.',4,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));

-- Identity Type Code
Insert into STUDENT.IDENTITY_TYPE_CODE (IDENTITY_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('BCSC','BC Services Card','Digital Identity via a BC Services Card, serviced by CITZ/IDIM.',1,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.IDENTITY_TYPE_CODE (IDENTITY_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('BASIC','Basic BCeID','Digital Identity via a Basic BCeID, serviced by CITZ/IDIM.',2,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.IDENTITY_TYPE_CODE (IDENTITY_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('PERSONAL','Personal BCeID','Digital Identity via a Personal BCeID, serviced by CITZ/IDIM.',3,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));

-- PEN Retrieval Request Status Code
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('DRAFT','Draft','Request created but not yet submitted.',1,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('INITREV','First Review','Request has been submitted and is now in it''s first review by staff.',2,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('RETURNED','Returned for more information','Request has been returned to the submitter for more information.',3,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('SUBSREV','Subsequent Review','Request has been resubmitted with more info and is now in another review by staff.',4,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('AUTO','Completed by auto-match','Request was completed by the auto-match process, without staff review.',5,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('MANUAL','Completed by manual match','Request was completed by staff determining the matching PEN.',6,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE (PEN_RETRIEVAL_REQUEST_STATUS_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('REJECTED','Could not be fulfilled','Request could not be fullfilled by staff for the reasons provided.',7,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));

-- Student Sex Code
Insert into STUDENT.STUDENT_SEX_CODE (SEX_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('F','Female','Persons who are of female sex as assigned at birth.',1,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.STUDENT_SEX_CODE (SEX_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('M','Male','Persons who were reported as being of male sex as assigned at birth.',2,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.STUDENT_SEX_CODE (SEX_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('I','Intersex','Persons who are intersex. Intersex people are born with any of several variations in sex characteristics, including chromosomes, gonads, sex hormones, or genitals that do not fit with typical conceptions of "male" or "female" bodies.',3,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));
Insert into STUDENT.STUDENT_SEX_CODE (SEX_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('U','Unknown','Persons whose sex is not known at the time of data collection. It may or may not get updated at a later point in time.',4,to_date('2020-01-01','YYYY-MM-DD'),to_date('2099-12-31','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'),'IDIR/GRCHWELO',to_date('2019-11-07','YYYY-MM-DD'));


-- PEN Retrieval Request Document Type Code
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('CABIRTH','Canadian Birth Certificate','Canadian Birth Certificate',10,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('CAPASSPORT','Canadian Passport','Canadian Passport',20,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('CADL','Canadian Driver''s Licence','Canadian Driver''s Licence',30,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('BCIDCARD','Provincial Identification Card','Provincial Identification Card',40,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('BCSCPHOTO','BC Services Card w Photo','BC Services Card (Photo version only)',50,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('CACITZCARD','Canadian Citizenship Card','Canadian Citizenship Card',60,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('PRCARD','Permanent Residence Card','Permanent Residence Card',70,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('STUDENTPMT','Student / Study Permit','Student / Study Permit',80,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('IMM5292','IMM5292 Conf of Perm Residence','Confirmation of Permanent Residence (IMM5292)',90,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('IMM1000','IMM1000 Record of Landing','Canadian Immigration Record of Landing (IMM 1000, not valid after June 2002)',100,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('INDSTATUS','Indian Status Card','Indian Status Card',110,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('NAMECHANGE','Legal Name Change document','Canadian court order approving legal change of name',120,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('FORPASSPRT','Foreign Passport','Foreign Passport',130,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('ADOPTION','Canadian adoption order','Canadian adoption order',140,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('MARRIAGE','Marriage Certificate','Marriage Certificate',150,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('FORBIRTH','Foreign Birth Certificate','Foreign Birth Certificate (with English translation)',160,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE (PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('OTHER','Other','Other document type',170,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/GRCHWELO',to_date('2019-12-20 00:00:00','YYYY-MM-DD HH24:MI:SS'));

-- PEN Retrieval Request Macro Type Code
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE (PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('MOREINFO','More Information Macro','Macros used when requesting that the student provide more information for a PEN Retrieval Request',1,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-02 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-02 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE (PEN_RETRIEVAL_REQUEST_MACRO_TYPE_CODE,LABEL,DESCRIPTION,DISPLAY_ORDER,EFFECTIVE_DATE,EXPIRY_DATE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values ('REJECT','Reject Reason Macro','Macros used when rejecting a PEN Retrieval Request',2,to_date('2020-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2099-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-02 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-02 00:00:00','YYYY-MM-DD HH24:MI:SS'));


-- PEN Retrieval Request Macro
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_MACRO (PEN_RETRIEVAL_REQUEST_MACRO_ID,MACRO_CODE,MACRO_TEXT,MACRO_TYPE_CODE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values (sys_guid(),'PCN','A PEN number can not be located using the information in your PEN request.'|| CHR(10) || CHR(10) ||'Please provide all other given names or surnames you have previously used or advise if you have never used any other names.','MOREINFO','IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_MACRO (PEN_RETRIEVAL_REQUEST_MACRO_ID,MACRO_CODE,MACRO_TEXT,MACRO_TYPE_CODE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values (sys_guid(),'PID','To continue with your PEN request upload an IMG or PDF of your current Government Issued photo Identification (ID).'|| CHR(10) || CHR(10) ||'NOTE: If the name listed on the ID you upload is different from what''s in the PEN system, we will update our data to match. ID is covered by the B.C. Freedom of Information Protection of Privacy.','MOREINFO','IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_MACRO (PEN_RETRIEVAL_REQUEST_MACRO_ID,MACRO_CODE,MACRO_TEXT,MACRO_TYPE_CODE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values (sys_guid(),'SOA','To continue with your PEN request please confirm the last B.C. Schools you attended or Graduated from, including any applications to B.C. Post Secondary Institutions','MOREINFO','IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_MACRO (PEN_RETRIEVAL_REQUEST_MACRO_ID,MACRO_CODE,MACRO_TEXT,MACRO_TYPE_CODE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values (sys_guid(),'NPF','A PEN number cannot be located using the information in your PEN request.' || CHR(10) || CHR(10) || 'For additional information copy and paste this link into the browser: https://www2.gov.bc.ca/gov/content?id=CCE3580078AD4F988579DD5EBB42BA85 .' || CHR(10) || CHR(10) || 'You do not require a PEN for an application to a B.C. school or PSI, a PEN will be assigned upon registration.','REJECT','IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_MACRO (PEN_RETRIEVAL_REQUEST_MACRO_ID,MACRO_CODE,MACRO_TEXT,MACRO_TYPE_CODE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values (sys_guid(),'OOP','The information provided in your PEN request indicates you may not have attended a B.C. School or public Post-Secondary Institution (PSI).'  || CHR(10) || CHR(10) ||  'You do not require a PEN for an application to a B.C. school or PSI, a PEN will be assigned upon registration.' || CHR(10) || CHR(10) || 'For additional information copy and paste this link into the browser: https://www2.gov.bc.ca/gov/content?id=CCE3580078AD4F988579DD5EBB42BA85','REJECT','IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'));
Insert into STUDENT.PEN_RETRIEVAL_REQUEST_MACRO (PEN_RETRIEVAL_REQUEST_MACRO_ID,MACRO_CODE,MACRO_TEXT,MACRO_TYPE_CODE,CREATE_USER,CREATE_DATE,UPDATE_USER,UPDATE_DATE) values (sys_guid(),'XPR','The identity of the person making the request cannot be confirmed as the same as the PEN owner.' || CHR(10) || CHR(10) ||  'Under the B.C. Freedom of Information Protection of Privacy Act, the PEN number can only be provided to the person assigned the PEN, that person’s current or future school, or that person’s parent or guardian.'  || CHR(10) || CHR(10) ||  'For additional information copy and paste this link into the browser: https://www2.gov.bc.ca/gov/content?id=CCE3580078AD4F988579DD5EBB42BA85','REJECT','IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'),'IDIR/JOCOX',to_date('2020-04-06 00:00:00','YYYY-MM-DD HH24:MI:SS'));

commit;

