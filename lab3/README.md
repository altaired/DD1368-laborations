# Questions

## 1

### A
[Source](e1.xqy)

### B

The solution is well formed XML because of the following:

* The result is contained in one root element (<result/>)
* The elements are defined and properly nested, inside
every continent element we have a country in which we have the
neccesary information of each country
* Well, it passes the Well formed XML test...

## 2

### A
[Source](e2.xqy)

### B

Both SQL and XQuery has a set of build in functions that are usefull. In the case of max and min functions both languages got them.
I would say that when using them they are very simililar. 
However in SQL min() usaully only get's you the min element, which XQuery also do but in XQuery its easy to retrive the parent element. 
In most cases you wan't the employee with the minimum salary and not only the salary.

#### SQL
```sql
SELECT MIN(salary) FROM employee;
```

#### XQuery
```xquery
let $salary := min($employee/salary)
let $employee := $salary/..
```

The parent element can of course be retrived from SQL as well but it looks like it's a way more time consuming task.

### C

Our results are presented in a similar way as Mondials original data, we are just selecting a subset of it. Well formated does not mean easily readable it just means that there are clear hierakies that order our information, but the file itself doesn't look well sorted. 

## 3 

### A
[Source](e3.xqy)

### B

SQL's GROUP BY operator orders the elements of the list in a way that they stay in the group that is specified. For example by the nr of mountains that a country has as is the case in lab 1.3. After taht we can then count the number in each category here. It gives us the ability to see a group as an element in the list.  

## 4 

### A
[Source](e4v2.xqy)

### B
[Good](e4v1.xqy)

[Better](e4v2.xqy)

## 5 

### A
[Source](e5.xqy)

### B

The data is in XML format which we have to convert from before we can use SQL on it. SQL doesn't handle arbetrary hieratical structures like linked lists.

## 6

### A
[Source](e6.xqy)

### B

## 7

Storage in SQL is in general easier to get an overview of since most of the text is relevent. SQL is in amany cases the standard despite the fact that there are several differnt dilects of it. In SQL it easy to soin andtho seperate data in different ways, since it is conveniently structured in tables.

Xquery is more similar to other programing languages which makes it easier use if you come from that background and have for example done web programing. In general statements can be written more consisely in xquery than in SQL
