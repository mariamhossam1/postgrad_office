create database PostgradOffice

create table PostGradUser(
ID int identity,
email varchar(50),
[password] varchar(20),
primary key(ID))

create table [Admin](
ID int primary key,
foreign key (ID) references PostGradUser on delete cascade on update cascade)

create table GucianStudent(
ID int,
firstName varchar(20),
lastName varchar(20),
[type] varchar(20),
faculty varchar(20),
[address] varchar(50),
GPA decimal(3,2),
undergradID int,
primary key(ID),
foreign key (ID) references PostGradUser on delete cascade on update cascade)

create table NonGucianStudent(
ID int,
firstName varchar(20),
lastName varchar(20),
[type] varchar(20),
faculty varchar(20),
[address] varchar(50),
GPA decimal(3,2),
primary key(ID),
foreign key (ID) references PostGradUser on delete cascade on update cascade)

create table GUCStudentPhoneNumber(
ID int,
phone varchar(20),
primary key (ID, phone),
foreign key (ID) references GucianStudent on delete cascade on update cascade)

create table NonGUCStudentPhoneNumber(
ID int,
phone varchar(20),
primary key (ID, phone),
foreign key (ID) references NonGucianStudent on delete cascade on update cascade)

create table Course(
ID int identity,
fees decimal,
creditHours int,
code varchar(10),
primary key (ID))

create table Supervisor(
ID int,
[name] varchar(20),
faculty varchar(20),
primary key (ID),
foreign key (ID) references PostGradUser on delete cascade on update cascade)

create table Payment(
ID int identity,
amount decimal,
no_Installments int,
fundPercentage decimal,
primary key (ID))

create table Thesis(
serialNumber int identity,
field varchar(20),
[type] varchar(20),
title varchar(50),
startDate date,
endDate date,
defenseDate datetime,
years as year(endDate) - year(startDate),
grade decimal,
payment_id int,
noExtension int,
primary key (serialNumber),
foreign key (payment_id) references Payment on delete cascade on update cascade)

create table Publication(
ID int identity,
title varchar(50),
[date] date,
place varchar(20),
accepted bit,
host varchar(20),
primary key(ID))

create table Examiner(
ID int,
[name] varchar(20),
fieldOfWork varchar(50),
isNational bit,
primary key (ID),
foreign key (ID) references PostGradUser on delete cascade on update cascade)

create table Defense(
serialNumber int,
[date] datetime,
[location] varchar(20),
grade decimal,
primary key (serialNumber, [date]),
foreign key (serialNumber) references Thesis on delete cascade on update cascade)

create table GUCianProgressReport(
[sid] int,
[no] int,
[date] date,
eval int,
[state] int,
[description] varchar(500),
thesisSerialNumber int,
supid int,
primary key ([sid], [no]),
foreign key ([sid]) references GucianStudent on delete cascade on update cascade,
foreign key (thesisSerialNumber) references Thesis on delete cascade on update cascade,
foreign key (supid) references Supervisor)

create table NonGUCianProgressReport(
[sid] int,
[no] int,
[date] date,
eval int,
[state] int,
[description] varchar(500),
thesisSerialNumber int,
supid int,
primary key ([sid], [no]),
foreign key ([sid]) references NonGucianStudent on delete cascade on update cascade,
foreign key (thesisSerialNumber) references Thesis on delete cascade on update cascade,
foreign key (supid) references Supervisor)

create table Installment(
[date] date,
paymentId int,
amount decimal,
done bit,
primary key ([date], paymentId),
foreign key (paymentId) references Payment on delete cascade on update cascade)

create table NonGucianStudentPayForCourse(
[sid] int,
paymentNo int,
cid int,
primary key ([sid], paymentNo, cid),
foreign key ([sid]) references NonGucianStudent on delete cascade on update cascade,
foreign key (paymentNo) references Payment on delete cascade on update cascade,
foreign key (cid) references Course on delete cascade on update cascade)

create table NonGucianStudentTakeCourse(
[sid] int,
cid int,
grade decimal,
primary key ([sid], cid),
foreign key ([sid]) references NonGucianStudent on delete cascade on update cascade,
foreign key (cid) references Course on delete cascade on update cascade)

create table GUCianStudentRegisterThesis(
[sid] int,
supid int,
serialNo int,
primary key ([sid], supid, serialNo),
foreign key ([sid]) references GucianStudent on delete cascade on update cascade,
foreign key (supid) references Supervisor,
foreign key (serialNo) references Thesis on delete cascade on update cascade)

create table NonGUCianStudentRegisterThesis(
[sid] int,
supid int,
serialNo int,
primary key ([sid], supid, serialNo),
foreign key ([sid]) references NonGucianStudent on delete cascade on update cascade,
foreign key (supid) references Supervisor,
foreign key (serialNo) references Thesis on delete cascade on update cascade)

create table ExaminerEvaluateDefense(
[date] datetime,
serialNo int,
examinerId int,
comment varchar(200),
primary key ([date], serialNo, examinerId),
foreign key (serialNo, [date]) references Defense on delete cascade on update cascade,
foreign key (examinerId) references Examiner on delete cascade on update cascade)

create table ThesisHasPublication(
serialNo int,
pubid int,
primary key (serialNo, pubid),
foreign key (serialNo) references Thesis on delete cascade on update cascade,
foreign key (pubid) references Publication on delete cascade on update cascade)