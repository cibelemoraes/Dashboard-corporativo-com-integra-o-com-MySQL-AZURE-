USE `suporte_cibele_moraes_teste`;

CREATE TABLE employee (
  Fname varchar(15) NOT NULL,
  Minit char,
  Lname varchar(15) NOT NULL,
  Ssn char(9) NOT NULL PRIMARY KEY,
  Bdate date,
  Address varchar(30),
  Sex char,
  Salary decimal(10,2) CHECK (Salary > 2000.0),
  Super_ssn char(9),
  Dno int NOT NULL DEFAULT 1,
  CONSTRAINT fk_employee FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- Rest of the CREATE TABLE statements for department, dept_locations, project, works_on, and dependent (unchanged)

USE `suporte_cibele_moraes_teste`;

CREATE TABLE department (
   Dname varchar(15) NOT NULL,
   Dnumber int NOT NULL PRIMARY KEY,
   Mgr_ssn char(9) NOT NULL,
   Mgr_start_date date,
   Dept_create_date date,
   CONSTRAINT fk_dept FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn) ON UPDATE CASCADE,
   CONSTRAINT chk_dates CHECK (Dept_create_date < Mgr_start_date)
);

USE `suporte_cibele_moraes_teste`;
CREATE TABLE dept_locations (
  Dnumber int NOT NULL,
  Dlocation varchar(15) NOT NULL,
  PRIMARY KEY (Dnumber, Dlocation),
  CONSTRAINT fk_dept_locations FOREIGN KEY (Dnumber) REFERENCES department(Dnumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
USE `suporte_cibele_moraes_teste`;
CREATE TABLE project (
  Pname varchar(15) NOT NULL,
  Pnumber int NOT NULL PRIMARY KEY,
  Plocation varchar(15),
  Dnum int NOT NULL,
  CONSTRAINT unique_project UNIQUE (Pname),
  CONSTRAINT fk_project FOREIGN KEY (Dnum) REFERENCES department(Dnumber)
);
-- Adicionando colunas
ALTER TABLE project
ADD COLUMN Pname varchar(15) NOT NULL,
ADD COLUMN Pnumber int NOT NULL,
ADD COLUMN Plocation varchar(15),
ADD COLUMN Dnum int NOT NULL;

-- Definindo chave primária
ALTER TABLE project
ADD CONSTRAINT pk_project PRIMARY KEY (Pnumber);

-- Adicionando restrição única
ALTER TABLE project
ADD CONSTRAINT unique_project UNIQUE (Pname);

-- Adicionando chave estrangeira
ALTER TABLE project
ADD CONSTRAINT fk_project FOREIGN KEY (Dnum) REFERENCES department(Dnumber);
DESCRIBE project;

SELECT Pnumber, COUNT(*)
FROM project
GROUP BY Pnumber
HAVING COUNT(*) > 1;

SELECT *
FROM project
WHERE Pnumber = 0;

ALTER TABLE project
ADD UNIQUE (Pnumber);







USE `suporte_cibele_moraes_teste`;
-- Adicionando índice único em Pnumber
ALTER TABLE project
ADD UNIQUE (Pnumber);

-- Criando a tabela works_on
CREATE TABLE works_on (
  Essn char(9) NOT NULL,
  Pno int NOT NULL,
  Hours decimal(3,1) NOT NULL,
  PRIMARY KEY (Essn, Pno),
  CONSTRAINT fk_employee_works_on FOREIGN KEY (Essn) REFERENCES employee(Ssn),
  CONSTRAINT fk_project_works_on FOREIGN KEY (Pno) REFERENCES project(projectid)
);


USE `suporte_cibele_moraes_teste`;

CREATE TABLE dependent (
  Essn char(9) NOT NULL,
  Dependent_name varchar(15) NOT NULL,
  Sex char,
  Bdate date,
  Relationship varchar(8),
  PRIMARY KEY (Essn, Dependent_name),
  CONSTRAINT fk_dependent FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);

ALTER TABLE employee MODIFY Super_ssn char(9); 
ALTER TABLE employee MODIFY Super_ssn char(9); 


