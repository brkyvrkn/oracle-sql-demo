ALTER TABLE DRUG DROP CONSTRAINT DRG_FK;
ALTER TABLE PRESCRIPTION DROP CONSTRAINT PREP_FK;
ALTER TABLE SUPPLIERS DROP CONSTRAINT SUPP_FK_1;
ALTER TABLE SUPPLIERS DROP CONSTRAINT SUPP_FK_2;

DROP TABLE DRUG_COMP;
DROP TABLE DRUG_SUPP;
DROP TABLE PHARMACY;
DROP TABLE INVENTORY;
DROP TABLE PATIENT;

DROP TABLE DRUG;
DROP TABLE PRESCRIPTION;
DROP TABLE EMPLOYEE;
DROP TABLE SUPPLIERS;

ALTER SESSION SET nls_language='ENGLISH';
ALTER SESSION SET nls_date_format='DD-MON-YYYY';

-- Which does not contain foreign key
-- Tag: DC
CREATE TABLE DRUG_COMP 
    (DC_ID NUMBER(11) NOT NULL, 
    DC_NAME VARCHAR2(20) NOT NULL, 
    DC_ADDRESS VARCHAR2(100),
    CONSTRAINT DC_PK PRIMARY KEY(DC_ID) USING INDEX ENABLE);

-- Tag: DS
CREATE TABLE DRUG_SUPP
    (DS_ID NUMBER(11) NOT NULL,
    DS_NAME VARCHAR2(20) NOT NULL, 
    DS_ADDRESS VARCHAR2(100),
    CONSTRAINT DS_PK PRIMARY KEY(DS_ID) USING INDEX ENABLE);

-- Tag: PHA
CREATE TABLE PHARMACY
    (PHA_ID NUMBER(11) NOT NULL,
    PHA_CONTACT NUMBER(11),
    PHA_ADDRESS VARCHAR2(100),
    CONSTRAINT PHA_PK PRIMARY KEY (PHA_ID) USING INDEX ENABLE);

-- Tag: INV
CREATE TABLE INVENTORY
    (INV_ID NUMBER(11) NOT NULL,
    INV_AMOUNT NUMBER(13),
    INV_PHA_ID NUMBER(11) NOT NULL,
    CONSTRAINT INV_PK PRIMARY KEY (INV_ID) USING INDEX ENABLE);

-- Tag: PT
CREATE TABLE PATIENT
    (PT_ID NUMBER(11) NOT NULL,
    PT_NAME VARCHAR2(15) NOT NULL,
    PT_SURNAME VARCHAR2(20) NOT NULL,
    PT_BIRTHDATE DATE,
    PT_CONTACT VARCHAR2(100),
    CONSTRAINT PT_PK PRIMARY KEY (PT_ID) USING INDEX ENABLE);

-- Which contain foreign keys
-- Tag: DRG
CREATE TABLE DRUG
    (DRG_ID NUMBER(13,0) NOT NULL,
    DRG_NAME VARCHAR2(35) NOT NULL,
    DRG_TYPE VARCHAR2(15) NOT NULL,
    DRG_COMP_ID NUMBER(13,0) NOT NULL,
    DRG_SELLING_PRC NUMBER(6,2) NOT NULL,
    DRG_BUYING_PRC NUMBER(6,2) NULL,
    DRG_GOV_SUPPORT NUMBER(2,2) NULL,
    DRG_EXPIRE DATE NOT NULL,
    CONSTRAINT DRG_PK PRIMARY KEY (DRG_ID) USING INDEX ENABLE);

-- Tag: PREP
CREATE TABLE PRESCRIPTION
    (PREP_ID NUMBER(13,0) NOT NULL,
    PREP_DATE DATE NOT NULL,
    PREP_TYPE VARCHAR2(20),
    PREP_PT_ID NUMBER(13) NOT NULL,
    PREP_DR_ID NUMBER(13),
    CONSTRAINT PREP_PK PRIMARY KEY (PREP_ID) USING INDEX ENABLE);

-- Tag: EMP
CREATE TABLE EMPLOYEE
    (EMP_ID NUMBER(11) NOT NULL,
    EMP_NAME VARCHAR2(15) NOT NULL,
    EMP_SAL NUMBER(5),
    EMP_CONTACT VARCHAR2(100),
    CONSTRAINT EMP_PK PRIMARY KEY (EMP_ID) USING INDEX ENABLE);

-- Tag: SUPP
CREATE TABLE SUPPLIERS 
    (SUPP_ID NUMBER(11) NOT NULL, 
    SUPP_DS_ID NUMBER(11) NOT NULL, 
    SUPP_DRG_ID NUMBER(13) NOT NULL,
    CONSTRAINT SUPP_PK PRIMARY KEY (SUPP_ID) USING INDEX ENABLE);


ALTER TABLE DRUG ADD CONSTRAINT DRG_FK
    FOREIGN KEY (DRG_COMP_ID) REFERENCES DRUG_COMP(DC_ID);

ALTER TABLE PRESCRIPTION ADD CONSTRAINT PREP_FK
    FOREIGN KEY (PREP_PT_ID) REFERENCES PATIENT(PT_ID);

ALTER TABLE SUPPLIERS ADD CONSTRAINT SUPP_FK_1
    FOREIGN KEY (SUPP_DS_ID) REFERENCES DRUG_SUPP(DS_ID);

ALTER TABLE SUPPLIERS ADD CONSTRAINT SUPP_FK_2
    FOREIGN KEY (SUPP_DRG_ID) REFERENCES DRUG(DRG_ID);

ALTER TABLE INVENTORY ADD CONSTRAINT INV_FK
    FOREIGN KEY (INV_PHA_ID) REFERENCES PHARMACY(PHA_ID);