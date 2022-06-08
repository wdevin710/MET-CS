USE BOSTON_PAPER;
DELIMITER //
CREATE PROCEDURE emp_info( Emp_Number INT)
BEGIN

SELECT EmpNo,EmpName, Salary
FROM EMPLOYEE
WHERE EmpNo = Emp_Number;

END//
DELIMITER ;

-- Test;
CALL emp_info(2);

DELIMITER //
CREATE PROCEDURE emp_orders(IN emp_number INT)
BEGIN

SELECT EmpName, customer.CName, SUM(Amount) AS OrderAmount
FROM employee, customer, paper_order, handles
WHERE employee.EmpNo = handles.EmpNo AND handles.OrderNo = paper_order.OrderNo
      AND customer.CName = paper_order.CName AND employee.EmpNo = emp_number
      GROUP BY employee.EmpNo, customer.CName;

END//
DELIMITER ;

-- Test;
CALL emp_orders(2);

DELIMITER //
CREATE PROCEDURE get_phone(IN cust_name CHAR(5), IN branch_number INT)
BEGIN

SELECT BRANCH.PHONE
FROM BRANCH, CUSTOMER
WHERE customer.CName = branch.CName AND customer.CName = cust_name
	AND branch.BrNo = branch_number;

END //
DELIMITER ;

-- Test ;
CALL get_phone('Hao',5);


delimiter //
create trigger max_emp
    after insert on handles
    for each row
begin
    declare num_emp tinyint;
select count(*) into num_emp
from handles
where OrderNo = new.OrderNo;
    if num_emp >= 2 then
        signal SQLSTATE '45000'
            set message_text = 'An employee may work on up to 2 Order.';
    end if;
end //
delimiter ;

-- Test;
insert into handles values (5, 1);


delimiter //
create trigger date_inconsistency
    before update on suborder
    for each row
begin
     
    if new.ReqShipDate > new.ActualShipDate then
        signal SQLSTATE '45000'  
            set message_text = 'Manager start date cannot be earlier then DOB';
    end if;
end //
delimiter ;

-- Test;
insert into suborder values (5, 'Jia',23, '2000-07-01', '2000-06-01', 3);


