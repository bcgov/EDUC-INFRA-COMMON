--Services Card Proxy
CREATE OR REPLACE SYNONYM PROXY_SERVICES_CARD.SERVICES_CARD_INFO
    FOR STUDENT.SERVICES_CARD_INFO;
    
--Digital ID Proxy
CREATE OR REPLACE SYNONYM PROXY_DIGITAL_ID.DIGITAL_IDENTITY
    FOR STUDENT.DIGITAL_IDENTITY;
CREATE OR REPLACE SYNONYM PROXY_DIGITAL_ID.ACCESS_CHANNEL_CODE
    FOR STUDENT.ACCESS_CHANNEL_CODE;
CREATE OR REPLACE SYNONYM PROXY_DIGITAL_ID.IDENTITY_TYPE_CODE
    FOR STUDENT.IDENTITY_TYPE_CODE;

--Student Proxy
CREATE OR REPLACE SYNONYM PROXY_STUDENT.STUDENT
    FOR STUDENT.STUDENT;
CREATE OR REPLACE SYNONYM PROXY_STUDENT.STUDENT_GENDER_CODE
    FOR STUDENT.STUDENT_GENDER_CODE;    
CREATE OR REPLACE SYNONYM PROXY_STUDENT.STUDENT_SEX_CODE
    FOR STUDENT.STUDENT_SEX_CODE;
    
--PEN Retrieval Proxy
CREATE OR REPLACE SYNONYM PROXY_PEN_RETRIEVAL.PEN_RETRIEVAL_REQUEST
    FOR STUDENT.PEN_RETRIEVAL_REQUEST;
CREATE OR REPLACE SYNONYM PROXY_PEN_RETRIEVAL.PEN_RETRIEVAL_REQUEST_COMMENT
    FOR STUDENT.PEN_RETRIEVAL_REQUEST_COMMENT;
CREATE OR REPLACE SYNONYM PROXY_PEN_RETRIEVAL.PEN_RETRIEVAL_REQUEST_DOCUMENT
    FOR STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT;
CREATE OR REPLACE SYNONYM PROXY_PEN_RETRIEVAL.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE
    FOR STUDENT.PEN_RETRIEVAL_REQUEST_DOCUMENT_TYPE_CODE;
CREATE OR REPLACE SYNONYM PROXY_PEN_RETRIEVAL.PEN_RETRIEVAL_REQUEST_GENDER_CODE
    FOR STUDENT.PEN_RETRIEVAL_REQUEST_GENDER_CODE;
CREATE OR REPLACE SYNONYM PROXY_PEN_RETRIEVAL.PEN_RETRIEVAL_REQUEST_STATUS_CODE
    FOR STUDENT.PEN_RETRIEVAL_REQUEST_STATUS_CODE;

--PEN Demog
CREATE OR REPLACE EDITIONABLE SYNONYM PROXY_PEN_DEMOG.PEN_DEMOG FOR "PEN_DEMOG"@"PENLINK.WORLD";