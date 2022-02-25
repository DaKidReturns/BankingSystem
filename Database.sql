CREATE TABLE LOGINTAB (
  USERNAME CHAR(20) NOT NULL UNIQUE,
  PASSWORD CHAR(20) NOT NULL,
  USERTYPE CHAR(8) NOT NULL,
  CONSTRAINT PK_LOGINTAB PRIMARY KEY(USERNAME)
);

CREATE TABLE CUSTOMER (
  CUSTOMER_ID INTEGER NOT NULL UNIQUE,
  CUS_NAME VARCHAR(20) NOT NULL,
  CUS_ADDRESS VARCHAR(50) NOT NULL,
  USERNAME CHAR(20) UNIQUE REFERENCES LOGINTAB(USERNAME),
  CONSTRAINT PK_CUSTOMER PRIMARY KEY(CUSTOMER_ID)
);

CREATE TABLE BANKER (
  ID INTEGER NOT NULL UNIQUE,
  NAME VARCHAR(20) NOT NULL UNIQUE,
  JOINDATE DATE,
  USERNAME CHAR(20) NOT NULL UNIQUE,
  CONSTRAINT PK_BANKER PRIMARY KEY(ID)
);

CREATE TABLE ACCOUNT (
  ACCOUNTNO INTEGER UNIQUE,
  CUSTOMER_ID INTEGER REFERENCES CUSTOMER(CUSTOMER_ID),
  BALANCE FLOAT,
  MIN_BAL FLOAT,
  CONSTRAINT PK_ACCOUNT PRIMARY KEY(ACCOUNTNO)
);
  
CREATE TABLE TRANSACTN(
  TRANSID INTEGER NOT NULL AUTO_INCREMENT,
  ACCOUNTNO INTEGER REFERENCES ACCOUNT(ACCOUNTNO),
  STATUS CHAR(20) NOT NULL,
  AMOUNT FLOAT,
  CONSTRAINT PK_TRANSACTION PRIMARY KEY(TRANSID)
);
  
CREATE TABLE LOAN(
  LOANNO INTEGER UNIQUE NOT NULL AUTO_INCREMENT,
  CUSTOMER_ID INTEGER REFERENCES CUSTOMER(CUSTOMER_ID),
  AMOUNT FLOAT,
  YEARS INTEGER,
  INTEREST INTEGER,
  CONSTRAINT PK_LOAN PRIMARY KEY(LOANNO)
);
--ALTER TABLE `BANK`.`LOAN` 
--CHANGE COLUMN `LOANNO` `LOANNO` INT NOT NULL AUTO_INCREMENT ;

CREATE TABLE LOANTYPETAB (
  id int NOT NULL,
  LOANNAME varchar(45) NOT NULL UNIQUE,
  INTREST float NOT NULL,
  NUMYEARS int NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO LOGINTAB VALUES('AISHWARYA','AISHU@2000$','CUST');
INSERT INTO LOGINTAB VALUES('MANU_M','ONEPIECE121*','CUST');
INSERT INTO LOGINTAB VALUES('GAUTHAM_R','GAUTHAMR@178','CUST');
INSERT INTO LOGINTAB VALUES('ANVAR','ANVARKK#','CUST');
INSERT INTO LOGINTAB VALUES('ASWIN_JS','ASWIN1999','BANKER');
INSERT INTO LOGINTAB VALUES('ARAVIND_NAIR','SUNSHINE$','BANKER');
INSERT INTO LOGINTAB VALUES('JYOTHI','SURYAA100%','BANKER');
INSERT INTO LOGINTAB VALUES('ARJUN_S','ARJUN567','BANKER');


INSERT INTO CUSTOMER VALUES('1000','AISHWARYA','AK STREET','AISHWARYA');
INSERT INTO CUSTOMER VALUES('1001','MANU M','PTR STREET','MANU_M');
INSERT INTO CUSTOMER VALUES('1002','GAUTHAM R','TN NAGAR','GAUTHAM_R');
INSERT INTO CUSTOMER VALUES('1003','ANVAR KK','PTR STREET','ANVAR');


INSERT INTO BANKER VALUES('121','ASWIN JS','2010/08/22','ASWIN_JS');
INSERT INTO BANKER VALUES('122','ARAVIND NAIR','2015/03/14','ARAVIND_NAIR');
INSERT INTO BANKER VALUES('123','JYOTHI K','2011/07/03','JYOTHI');
INSERT INTO BANKER VALUES('124','ARJUN S','2011/05/21','ARJUN_S');


INSERT INTO ACCOUNT VALUES('12345','1000','12045','1000');
INSERT INTO ACCOUNT VALUES('43244','1000','12045','1000');
INSERT INTO ACCOUNT VALUES('12346','1001','3080','1000');
INSERT INTO ACCOUNT VALUES('12347','1002','15000','1000');
INSERT INTO ACCOUNT VALUES('12348','1003','48999','1000');


INSERT INTO TRANSACTN VALUES('7708','12347','DEPOSIT','5000');
INSERT INTO TRANSACTN VALUES('7709','12345','WITHDRAWAL','6500');
INSERT INTO TRANSACTN VALUES('7710','12346','WITHDRAWAL','4000');
INSERT INTO TRANSACTN VALUES('7711','12348','DEPOSIT','3000');
INSERT INTO TRANSACTN VALUES('7712','12345','DEPOSIT','10000');


INSERT INTO LOAN VALUES('3000','1000','500000','3','10');
INSERT INTO LOAN VALUES('3001','1003','700000','4','10');

INSERT INTO `BANK`.`LOANTYPETAB` (`id`, `LOANNAME`, `INTREST`, `NUMYEARS`) VALUES ('1', 'Student', '8', '5');
INSERT INTO `BANK`.`LOANTYPETAB` (`id`, `LOANNAME`, `INTREST`, `NUMYEARS`) VALUES ('2', 'Housing', '12', '10');
INSERT INTO `BANK`.`LOANTYPETAB` (`id`, `LOANNAME`, `INTREST`, `NUMYEARS`) VALUES ('3', 'Personal', '10', '5');
INSERT INTO `BANK`.`LOANTYPETAB` (`id`, `LOANNAME`, `INTREST`, `NUMYEARS`) VALUES ('4', 'Mortgage', '13.4', '25');


SELECT* FROM TRANSACTN;

-- Trigger for checking whether the withdraw is valid or not.
DELIMITER $$
CREATE TRIGGER WITHDRAWCHECK
BEFORE UPDATE ON ACCOUNT 
FOR each row 
BEGIN
	DECLARE errorMessage VARCHAR(255);
	IF NEW.BALANCE < 0.0 THEN
		signal SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR BANK BALANCE CANT BE ZERO' ;
	END IF;
END $$

DELIMITER ;

-- Trigger for checking loan request
DELIMITER $$
CREATE TRIGGER LOANINCHECK
BEFORE INSERT ON LOAN 
FOR each row 
BEGIN
	
	IF NEW.AMOUNT <= 0.0 THEN
		signal SQLSTATE '45000' SET MESSAGE_TEXT = 'Principle cant be zero' ;
	ELSEIF NEW.YEARS <= 0 THEN
		SIGNAL sqlstate '45000' SET message_text = 'Time (in years) cant be zero';
	ELSEIF NEW.INTEREST <=0 THEN
		SIGNAL sqlstate '45000' SET MESSAGE_TEXT = 'Interest cant be zero';
	end if;
	
END $$
DELIMITER ;

