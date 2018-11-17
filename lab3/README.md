# Questions

## 1 B

The solution is well formed XML because of the following:

* The result is contained in one root element (<result/>)
* The elements are defined and properly nested, inside
every continent element we have a country in which we have the
neccesary information of each country
* Well, it passes the Well formed XML test...

## 2 B

Both SQL and XQuery has a set of build in functions that are usefull. In the case of max and min functions both languages got them.
I would say that when using them they are very simililar. 
However in SQL min() usaully only get's you the min element, which XQuery also do but in XQuery its easy to retrive the parent element. 
In most cases you wan't the employee with the minimum salary and not only the salary.

### SQL
```sql
SELECT MIN(salary) FROM employee;
```

### XQuery
```xquery
let $salary := min($employee/salary)
let $employee := $salary/..
```

The parent element can of course be retrived from SQL as well but it looks like it's a way more time consuming task.

## 2 C

## 3 B

## 4 B

## 5 B

## 6 B

## 7


