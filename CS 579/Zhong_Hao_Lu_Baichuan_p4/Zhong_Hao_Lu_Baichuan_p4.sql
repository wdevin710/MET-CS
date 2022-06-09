use ordersys;
-- CS579 Project Part 4
-- Baichuan Lu, Hao Zhong

-- Problem 1 
DELIMITER $$
CREATE PROCEDURE emp_info(emp_number int)  
	BEGIN 
		SELECT EmpNo as 'Employee Number',EmpName as 'Employee Name',Salary 
		FROM employee
		where EmpNo=emp_number;
	END$$
delimiter ;
-- Test
Call emp_info(112233);

-- Problem 2
DELIMITER $$
CREATE PROCEDURE emp_order(emp_number int)  
BEGIN 
	SELECT a. EmpName,c.CName,c.Amount
	FROM employee a
	inner join handles b on a.EmpNo=b.EmpNo
	inner join paper_order c on b.OrderNo=c.OrderNo
	where a.EmpNo=emp_number;
END$$
DELIMITER ;
-- Test 
Call emp_order(112233);

-- Problem 3 
DELIMITER $$
CREATE FUNCTION get_phone(cust_name VARCHAR(20), branch_number CHAR(10))   
    RETURNS VARCHAR(20)  
    DETERMINISTIC
BEGIN 
	declare Phone_num varchar(20);
    select Phone into Phone_num from branch 
    where CName=cust_name and BrNo=branch_number;
    RETURN(Phone_num);
END$$
DELIMITER ;
-- Test
Select get_phone('CVS',1);

-- Problem 4
delimiter //
create trigger max_emp
	before insert on handles
	for each row
begin
	declare num_handle tinyint;
		select count(*) into num_handle
		from handles
		where OrderNo = new.OrderNo;
	if num_handle >= 2 then
		signal SQLSTATE '45000'
			set message_text = 'An Order can only be handled by most 2 employees.';
	end if;
end //
delimiter ;
-- Testers
insert into handles values (778899, 123); /* violates the constraint */
insert into handles values (112233, 789); /* no violation */


-- Problem 5 
delimiter //
create trigger date_inconsistency
	before insert on suborder
	for each row
begin
	if new.ReqShipDate > new.ActualShipDate then
		signal SQLSTATE '45000'
			set message_text = 'Order shipping date cannot be earlier than request date';
	end if;
end //
delimiter ;
-- Testers
Insert Into suborder Values (123, '003', '2007-04-01', '2007-03-01', 'Target', 3); /* violates the constraint */
Insert Into suborder Values (789, '003', '2008-03-09', '2008-03-10', 'Walmart', 3);  /* no violation */