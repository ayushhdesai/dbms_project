DROP DATABASE if exists dbms_project;
CREATE DATABASE dbms_project;

USE dbms_project;

CREATE TABLE Company (
  company_id INT PRIMARY KEY auto_increment,
  company_name VARCHAR(255) NOT NULL,
  company_description TEXT
);

CREATE TABLE Job (
  job_id INT PRIMARY KEY,
  job_title VARCHAR(255) NOT NULL,
  job_description TEXT,
  location VARCHAR(255),
  date_posted DATE
);

CREATE TABLE Skills (
  skills_id INT PRIMARY KEY,
  skill_name VARCHAR(255) NOT NULL,
  skill_description TEXT
);

CREATE TABLE User (
  user_id INT PRIMARY KEY auto_increment,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  phone_number VARCHAR(15)
);

CREATE TABLE Resume (
  resume_id INT PRIMARY KEY auto_increment,
  contact_info TEXT,
  education TEXT,
  skills TEXT,
  extra_curriculars TEXT
);

CREATE TABLE Job_applies (
  user_id INT,
  job_id INT,
  PRIMARY KEY (user_id, job_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id),
  FOREIGN KEY (job_id) REFERENCES Job(job_id)
);

CREATE TABLE Interviews (
  user_id INT,
  company_id INT,
  interviewer VARCHAR(255),
  interviewer_date DATE,
  interviewer_time TIME,
  PRIMARY KEY (user_id, company_id),
  FOREIGN KEY (user_id) REFERENCES User(user_id),
  FOREIGN KEY (company_id) REFERENCES Company(company_id)
);

CREATE TABLE Resume_skills (
  resume_id INT,
  skill_id INT,
  PRIMARY KEY (resume_id, skill_id),
  FOREIGN KEY (resume_id) REFERENCES Resume(resume_id),
  FOREIGN KEY (skill_id) REFERENCES Skills(skills_id)
);