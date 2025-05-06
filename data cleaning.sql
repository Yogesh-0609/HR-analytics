use hr
 Select  * from hr_res
 
 Alter table hr_res
 CHANGE COLUMN ï»¿id emp_id Varchar(20) NULL;

Describe hr_res
SET sql_safe_updates = 0;
 UPDATE hr_res
 SET birthdate = CASE
		WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate , '%m/%d/%Y'), '%Y-%m-%d')
        WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate , '%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL
        END;
	 Alter table hr_res
     MODIFY COLUMN birthdate DATE;
     
     
      UPDATE hr_res
 SET hire_date = CASE
		WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date , '%m/%d/%Y'), '%Y-%m-%d')
        WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date , '%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL
        END;
	 
	Alter table hr_res
    MODIFY COLUMN hire_date DATE 
    
    UPDATE hr_res 
    SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
    WHERE termdate is not null AND termdate != '';
    
    UPDATE hr_res
    SET termdate = null
    WHERE termdate = '';
    
    ALTER TABLE hr_res ADD column AGE int
    
    update hr_res
    SET AGE = timestampdiff(YEAR,birthdate,curdate())
    
    
    
    
     