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
    
    SELECT min(age),max(age) from hr_res
    Select * from hr_res
    
    ------GENDER BREAKDOWN--------------------------------------------
    SELECT  gender, COUNT(*) AS count from hr_res
    where termdate is NULL
    GROUP BY gender;
 -------------------RACE BREAKDOWN--------------------------------------
     SELECT race, COUNT(*) AS COUNT from hr_res
     WHERE termdate is NULL
     GROUP BY race
  ------------------------AGE DISTRUBUTION----------------------
  SELECT 
		CASE 
			WHEN age>=18 AND age<=24 THEN '18-24'
            WHEN age>=25 AND age<=34 THEN '25-34'
            WHEN age>=35 AND age<=44 THEN '35-44'
            WHEN age>=45 AND age<=54 THEN '45-54'
            WHEN  age>=55 AND age<=64 THEN '55-64'
            ELSE '65+'
		END AS age_group,
        COUNT(*) as count 
        from hr_res
        WHERE termdate is NULL
        GROUP BY age_group
        ORDER BY age_group
	
    ---------------LOCATION------------------------------
    SELECT location,COUNT(*) as count
    FROM hr_res
    WHERE termdate IS NULL
    GROUP BY location
    
    -------AVERAGE LENGTH OF EMPLOYMENT WHO ARE TERMINATED-----------
    SELECT ROUND ( AVG(year(termdate) - year(hire_date)),0) as 		 length_of_emp
    from hr_res
    Where termdate is not null and termdate <= curdate()
     
     ---------------GENDER DISTRUBUTION------------------------
     SELECT department,gender,COUNT(*) AS count
     from hr_res
     WHERE termdate is NOT NULL
     GROUP BY department,gender
     ORDER BY department,gender
                         
     -------------JOB TITLE DISTRUBUTION BY COMPANY-------------
     SELECT jobtitle, COUNT(*) AS job_count
     FROM hr_res
     WHERE termdate IS NULL
     GROUP BY jobtitle
     
     ---------TERMINATION RATE BY DEPARTMENT WISE-------------------
     SELECT * FROM hr_res
     
     SELECT department,
			  COUNT(*) AS total_count,
              COUNT( CASE
						WHEN termdate is NOT NULL AND termdate <= curdate() THEN 1
                        END) AS terminated_count,
			 ROUND((COUNT( CASE
						WHEN termdate is NOT NULL AND termdate <= curdate() THEN 1
                        END)/COUNT(*))*100,2) AS termination_rate
			FROM hr_res
            GROUP BY department
            ORDER BY termination_rate DESC
            
            --------------DISTRUBUTION EMPLOYEE ACROSS LOCATION--------------------------------------------
		SELECT location_state, COUNT(*) as count
        FROM hr_res
        WHERE termdate IS NULL
        GROUP BY location_state
        
        SELECT location_city, COUNT(*) as count
        FROM hr_res
        WHERE termdate IS NULL
        GROUP BY location_city
        
	------COMPANYS EMPLOYEE COUNT CHANGED OVER TIME BASED ON HIRE AND TERMINAION DATE------------------------------
     SELECT  * FROM hr_res
      
      SELECT year,
			hires,
            terminations,
            hires-terminations  AS net_change,
            (terminations/hires)*100 AS change_percent
            FROM(
					SELECT YEAR(hire_date) AS year,
                    COUNT(*) AS hires,
                    SUM(CASE
                              WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
						END) AS terminations
					FROM hr_res
                    GROUP BY YEAR(hire_date)) AS subquery
			GROUP BY year
            ORDER BY year;
            
--------------------------TENURE DISTRIBUTION BY EACH DEPAREMENT----------------------------------
     SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
     FROM hr_res
     WHERE termdate IS NOT NULL AND termdate <= curdate()
     GROUP BY department 
      ORDER BY avg_tenure 
     
     
    
     