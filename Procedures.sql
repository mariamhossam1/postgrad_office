-- As an unregistered user I should be able to:
-- 1a) Register to the website by using my name, password, email, faculty and address (Student)
go
create proc StudentRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@Gucian bit,
@email varchar(50),
@address varchar(50)
AS
declare @vari int
insert into PostGradUser
values(@email, @password)
set @vari = scope_identity();
if @Gucian = '1'
insert into GucianStudent(ID, firstName, lastName, faculty, address)
values (@vari, @first_name,@last_name, @faculty,  @address)
else
insert into NonGucianStudent(ID, firstName, lastName, faculty, address)
values (@vari, @first_name,@last_name, @faculty, @address)

--- 1a) Register to the website by using my name, password, email, faculty and address (Supervisor)
go
create proc SupervisorRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@email varchar(50)
AS
declare @vari int
insert into PostGradUser
values(@email, @password)
set @vari = scope_identity()
insert into Supervisor
values (@vari, @first_name +' '+@last_name, @faculty)

-- As any registered user I should be able to:
-- 2a) login using my username and password
go
create Proc userLogin
@ID int,
@password varchar(20),
@Success bit output
AS
if (EXISTS (select ID, password
			from PostGradUser
			where ID = @ID and password = @password))
Set @Success='1'
ELSE 
Set @Success='0';

-- 2b) add my mobile number(s)
go
create proc addMobile 
@ID int,
@mobile_number varchar(20)
AS
if (@ID IN (select ID
			from GucianStudent))
 Insert into GUCStudentPhoneNumber(ID, phone)
 values(@ID, @mobile_number)
 else if(@ID IN (select ID
				from NonGucianStudent))
Insert into NonGUCStudentPhoneNumber(ID, phone)
 values(@ID, @mobile_number)

 -- As an admin I should be able to:
 -- 3a) list all supervisors in the system
go
create proc AdminListSup
AS
select *
from Supervisor

-- 3b) view the profile of any supervisor that contains his/her information
go
create proc AdminViewSupervisorProfile
@SupID int
AS
select *
from Supervisor
where Supervisor.ID = @SupID

-- 3c) list all the theses in the system
go
create proc AdminViewAllTheses
AS
select *
from Thesis

-- 3d) list the number of ongoing theses
go
create proc AdminViewOnGoingTheses
@ThesisCount int output
AS
declare @ThesisC int
select ThesisC = count(*)
from Thesis
where endDate > CURRENT_TIMESTAMP or noExtension > 0
set @ThesisCount = @ThesisC
print @ThesisCount

-- 3e) list all supervisors' names currently supervising students, theses title, student name
go
create proc AdminViewStudentThesisBySupervisor
AS
select S.[name] as 'SupName', T.title, Stud.firstName+' '+Stud.lastName as 'StudentName'
from GUCianStudentRegisterThesis G
inner join GucianStudent Stud on (G.[sid] = Stud.ID)
inner join Thesis T on (G.serialNo = T.serialNumber)
inner join Supervisor S on (G.supid = S.ID)
union
select S2.[name] as 'SupName', T2.title, Stud2.firstName+' '+Stud2.lastName as 'StudentName'
from NonGUCianStudentRegisterThesis G1
inner join NonGucianStudent Stud2 on (G1.[sid] = Stud2.ID)
inner join Thesis T2 on (G1.serialNo = T2.serialNumber)
inner join Supervisor S2 on (G1.supid = S2.ID)

-- 3f) list nonGucians names, course code and respective grade
go
create proc AdminListNonGucianCourse
@courseID int
AS
select G.firstName, G.lastName, C.code, T.grade
from NonGucianStudent G 
inner join NonGucianStudentTakeCourse T on (G.ID = T.sid)
inner join Course C on (T.cid = C.ID)
where T.cid = @courseID

-- 3g) update the number of thesis extensions by 1
go
create proc AdminUpdateExtension
@ThesisSerialNo int
As
	update Thesis 
	set noExtension=noExtension+1
	where serialNumber = @ThesisSerialNo

-- 3h) issue a thesis payment
go
create proc AdminIssueThesisPayment
@ThesisSerialNo int,
@amount decimal,
@noOfInstallments int,
@fundPercentage decimal,
@Success bit output 
AS
declare @vari int
insert into Payment
values(@amount, @noOfInstallments, @fundPercentage)
set @vari = scope_identity();
update Thesis
set payment_id = @vari
where serialNumber = @ThesisSerialNo
if(EXISTS(select Thesis.payment_id
			from Thesis
			where @vari = Thesis.payment_id))
set @Success = '1'
else
set @Success = '0'

-- 3i) view the profile of any student that contains all of his/her information
go
create proc AdminViewStudentProfile
@sid int
AS
IF(@sid IN(select G.ID
			from GucianStudent G))
select *
from PostGradUser P
inner join GucianStudent G1 on (G1.ID = P.ID)
where P.ID = @sid

ELSE

select *
from PostGradUser P1
inner join NonGucianStudent NG on (NG.ID = P1.ID)
where P1.ID = @sid

-- 3j) issue installments as per the number of installments for a certain payment every six months starting from entered date
go
create proc AdminIssueInstallPayment
@paymentID int, 
@InstallStartDate date
AS
declare @totalpayment decimal
declare @installment int
declare @installmentamount decimal
select @installment = P.no_Installments, @totalpayment = P.amount
from Payment P
where P.ID = @paymentID
set @installmentamount = @totalpayment/@installment
while (@installment > 0)
BEGIN
set @InstallStartDate = dateadd(month,6,@InstallStartDate)
set @installment -= 1;
insert into Installment
values(@InstallStartDate,@paymentID,@installmentamount,'0')
END;

-- 3k) list the title(s) of accepted publication(s) per thesis
go
create proc AdminListAcceptPublication
AS
select T.title,P.title
from Publication P
inner join ThesisHasPublication TP on (P.ID = TP.pubid)
inner join Thesis T on (TP.serialNo = T.serialNumber)
where P.accepted = '1'
group by T.title, P.title

-- 3l) add course to course table
go
create proc AddCourse
@courseCode varchar(10), 
@creditHrs int, 
@fees decimal
AS
insert into Course (code, creditHours, fees)
values(@courseCode, @creditHrs, @fees)

-- 3l) link courses to students
go
create proc linkCourseStudent
@courseID int, 
@studentID int
AS
insert into NonGucianStudentTakeCourse (sid, cid)
values (@studentID, @courseID)

-- 3l) add course grade
go
create proc addStudentCourseGrade
@courseID int, 
@studentID int, 
@grade decimal
AS
update NonGucianStudentTakeCourse
set grade = @grade
where (sid = @studentID) and (cid = @courseID)

-- 3m) view examiners and supervisor(s) names attending a thesis defense taking place on a certain date
go
create proc ViewExamSupDefense
@defenseDate datetime
AS
select E.ID, E.[name], S.ID, S.[name]
from Examiner E
inner join ExaminerEvaluateDefense EV on (E.ID = EV.examinerId)
inner join GUCianStudentRegisterThesis G on (EV.serialNo = G.serialNo)
inner join Supervisor S on (S.ID = G.supid)
UNION
select E1.ID, E1.[name], S1.ID, S1.[name]
from Examiner E1
inner join ExaminerEvaluateDefense EV1 on (E1.ID = EV1.examinerId)
inner join NonGUCianStudentRegisterThesis NG on (EV1.serialNo = NG.serialNo)
inner join Supervisor S1 on (S1.ID = NG.supid)
where @defenseDate = EV1.[date]

-- As a supervisor I am able to:
-- 4a) evaluate a student's progress report , and give evaluation value 0 to 3
go
create proc EvaluateProgressReport
@supervisorID int, 
@thesisSerialNo int, 
@progressReportNo int, 
@evaluation int
AS
IF(@evaluation >=0 and @evaluation <=3 and @thesisSerialNo IN(select G.serialNo
																from GUCianStudentRegisterThesis G))
update GUCianProgressReport
set eval = @evaluation
where supid = @supervisorID
and thesisSerialNumber = @thesisSerialNo
and no = @progressReportNo

ELSE

update NonGUCianProgressReport
set eval = @evaluation
where supid = @supervisorID
and thesisSerialNumber = @thesisSerialNo
and no = @progressReportNo

-- 4b) view all my students' names and years spent in thesis
go
create proc ViewSupStudentsYears
@supervisorID int
As
select G.firstName, G.lastName, T.years
from GucianStudent G
inner join GUCianStudentRegisterThesis GT on (G.ID = GT.[sid])
inner join Thesis T on (GT.serialNo = T.serialNumber)
where GT.supid = @supervisorID
union
select NG.firstName, NG.lastName, T.years
from NonGucianStudent NG
inner join NonGUCianStudentRegisterThesis NGT on (NG.ID = NGT.[sid])
inner join Thesis T on (NGT.serialNo = T.serialNumber)
where NGT.supid = @supervisorID

-- 4c) view supervisor profile
go
create proc SupViewProfile
@supervisorID int
AS
select *
from Supervisor S
where S.ID = @supervisorID

-- 4c) update supervisor profile
go
create proc UpdateSupProfile
@supervisorID int,
@name varchar(20),
@faculty varchar(20)
AS
update Supervisor 
set name = @name, faculty = @faculty
where ID = @supervisorID

-- 4d) view all publications of a student
go
create proc ViewAStudentPublications
@StudentID int
AS

IF(@StudentID IN(select G.ID
				from GucianStudent G))
select P.*
from Publication P
inner join ThesisHasPublication TP on (P.ID = TP.pubid)
inner join GUCianStudentRegisterThesis GT on (TP.serialNo = GT.serialNo)
where @StudentID = GT.[sid]

ELSE

select P2.*
from Publication P2
inner join ThesisHasPublication TP2 on (P2.ID = TP2.pubid)
inner join NonGUCianStudentRegisterThesis GT2 on (TP2.serialNo = GT2.serialNo)
where @StudentID = GT2.[sid]

-- 4e) add defense for a thesis, for nonGucian students all courses' grades should be greater than 50 percent (gucian)
go 
create proc AddDefenseGucian
@ThesisSerialNo int,
@DefenseDate Datetime,
@DefenseLocation varchar(15)
AS
insert into Defense(serialNumber, [date], [location])
values (@ThesisSerialNo,@DefenseDate,@DefenseLocation)

-- 4e) add defense for a thesis, for nonGucian students all courses' grades should be greater than 50 percent (nongucian)
go 
create proc AddDefenseNonGucian
@ThesisSerialNo int,
@DefenseDate Datetime,
@DefenseLocation varchar(15)
AS
if((select min(NGP.grade)
	from Thesis T
	inner join NonGUCianStudentRegisterThesis NGT on (T.serialNumber = NGT.serialNo)
	inner join NonGucianStudentTakeCourse NGP on (NGT.[sid] = NGP.[sid])
	where NGT.serialNo = @ThesisSerialNo) > 50)
insert into Defense(serialNumber,[date],[location])
values(@ThesisSerialNo,@DefenseDate,@DefenseLocation)
ELSE
print('All course grades must be higher than 50')

-- 4f) add examiner(s) for a defense
go
create proc AddExaminer
@ThesisSerialNo int, 
@DefenseDate Datetime , 
@ExaminerName varchar(20), 
@National bit, 
@fieldOfWork varchar(20)
AS
declare @vari int
insert into PostGradUser
values(null, null)
set @vari = scope_identity();
insert into Examiner
values(@vari, @ExaminerName, @fieldOfWork, @National)
insert into ExaminerEvaluateDefense([date], serialNo, examinerId)
values(@DefenseDate, @ThesisSerialNo, @vari)

-- 4g) cancel a thesis if the evaluation of the last progress report is zero
go
create proc CancelThesis
@ThesisSerialNo int
AS
IF(EXISTS(select G.thesisSerialNumber, max([no]) as 'latestreport'
from GUCianProgressReport G
where G.eval = 0 and G.thesisSerialNumber = @ThesisSerialNo
group by G.thesisSerialNumber))

delete from Thesis
where serialNumber = @ThesisSerialNo

IF(EXISTS(select NG.thesisSerialNumber, max([no]) as 'latestreport'
from NonGUCianProgressReport NG
where NG.eval = 0
group by NG.thesisSerialNumber))

delete from Thesis
where serialNumber = @ThesisSerialNo

-- 4h) add grade for a thesis
go
create proc AddGrade
@ThesisSerialNo int,
@grade decimal
AS
update Thesis
set grade = @grade
where serialNumber = @ThesisSerialNo

-- As an examiner I should be able to:
-- 5a) add grade for a defense
go
create proc AddDefenseGrade
@ThesisSerialNo int, 
@DefenseDate Datetime, 
@grade decimal
AS
update Defense
set grade = @grade
where serialNumber = @ThesisSerialNo and [date] = @DefenseDate

-- 5b) add comments for a defense
go
create proc AddCommentsGrade
@ThesisSerialNo int , 
@DefenseDate Datetime , 
@comments varchar(300)
AS

update ExaminerEvaluateDefense 
set comment=@comments
where serialNo=@ThesisSerialNo and [date]=@DefenseDate

-- As a registered student I should be able to:
-- 6a) view my profile that contains all my information
go
create proc viewMyProfile
@studentId int
AS
IF(@studentId IN(select G.ID
				from GucianStudent G))
select *
from PostGradUser P
inner join GucianStudent G on (P.ID = G.ID)
where @studentId = G.ID

ELSE
select *
from PostGradUser P
inner join NonGucianStudent NG on (P.ID = NG.ID)
where @studentId = NG.ID

-- 6b) edit my profile
go
create proc editMyProfile
@studentID int, 
@firstName varchar(10), 
@lastName varchar(10), 
@password varchar(10), 
@email varchar(10), 
@address varchar(10), 
@type varchar(10)
AS
update PostGradUser
set email = @email, [password] = @password
where ID = @studentID

IF(@studentID IN(select G.ID
				from GucianStudent G))
update GucianStudent
set firstName = @firstName, lastName = @lastName, [address] = @address, [type] = @type
where ID = @studentID

ELSE
update NonGucianStudent
set firstName = @firstName, lastName = @lastName, [address] = @address, [type] = @type
where ID = @studentID

-- 6c) as a gucian graduate, add my undergrad id
go
create proc addUndergradID
@studentID int, 
@undergradID varchar(10)
AS
update GucianStudent 
set undergradID = @undergradID
where ID = @studentID

-- 6d) as a nongucian student, view my courses' grades
go 
create proc ViewCoursesGrades
@studentID int
AS 
select NG.cid, C.code, NG.grade
from NonGucianStudentTakeCourse NG
inner join Course C on (NG.cid = C.ID)
where NG.[sid] = @studentID

-- 6e) view course payments and installments
go
create proc ViewCoursePaymentsInstall
@studentID int
AS
select P.*,I.*
from NonGucianStudentPayForCourse NC inner join Payment P 
on NC.paymentNo=P.ID inner join Installment I on (P.ID = I.paymentId)
where NC.[sid] = @studentID

-- 6e) view thesis payments and installments
go
create proc ViewThesisPaymentsInstall
@studentID int
AS
(select P.*,I.*
from NonGUCianStudentRegisterThesis NC inner join Thesis T
on (NC.serialNo = T.serialNumber) inner join Payment P on (P.ID = T.payment_id)
inner join Installment I on (P.ID = I.paymentId)
where NC.[sid] = @studentID)

UNION

(select P.*,I.*
from GUCianStudentRegisterThesis G inner join Thesis T
on (G.serialNo = T.serialNumber) inner join Payment P on (P.ID = T.payment_id)
inner join Installment I on (P.ID = I.paymentId)
where G.[sid] = @studentID)

-- 6e) view upcoming installments
go
create proc ViewUpcomingInstallments
@studentID int
AS
IF(@studentID IN(select NG1.ID
				from NonGucianStudent NG1))
select I.*
from Installment I
inner join Payment P on (I.paymentId = P.ID)
inner join Thesis T on (P.ID = T.payment_id)
inner join NonGUCianStudentRegisterThesis NG on (T.serialNumber = NG.serialNo)
where NG.[sid] = @studentID and I.[date] > CURRENT_TIMESTAMP

UNION

select I.*
from Installment I
inner join Payment P on (I.paymentId = P.ID)
inner join NonGucianStudentPayForCourse NC on (NC.paymentNo = P.ID)
where NC.[sid] = @studentID and I.[date] > CURRENT_TIMESTAMP

ELSE

select I.*
from Installment I
inner join Payment P on (I.paymentId = P.ID)
inner join Thesis T on (P.ID = T.payment_id)
inner join GUCianStudentRegisterThesis G on (T.serialNumber = G.serialNo)
where G.[sid] = @studentID and I.[date] > CURRENT_TIMESTAMP

-- 6e) view missed installments
go
create proc ViewMissedInstallments
@studentID int
AS
IF(@studentID IN(select NG1.ID
				from NonGucianStudent NG1))
select I.*
from Installment I
inner join Payment P on (I.paymentId = P.ID)
inner join Thesis T on (P.ID = T.payment_id)
inner join NonGUCianStudentRegisterThesis NG on (T.serialNumber = NG.serialNo)
where NG.[sid] = @studentID and I.[date] < CURRENT_TIMESTAMP and I.done = '0'

UNION

select I.*
from Installment I
inner join Payment P on (I.paymentId = P.ID)
inner join NonGucianStudentPayForCourse NC on (NC.paymentNo = P.ID)
where NC.[sid] = @studentID and I.[date] < CURRENT_TIMESTAMP and I.done = '0'

ELSE

select I.*
from Installment I
inner join Payment P on (I.paymentId = P.ID)
inner join Thesis T on (P.ID = T.payment_id)
inner join GUCianStudentRegisterThesis G on (T.serialNumber = G.serialNo)
where G.[sid] = @studentID and I.[date] < CURRENT_TIMESTAMP

-- 6f) add progress reports
go
create proc AddProgressReport
@thesisSerialNo int, 
@progressReportDate date
AS
declare @vari int
declare @varib int
declare @varic int

IF(@thesisSerialNo IN(select G.serialNo
						from GUCianStudentRegisterThesis G))
select @varib = max(GP.[no])
from GUCianProgressReport GP
where GP.thesisSerialNumber = @thesisSerialNo

ELSE

select @varib = max(NGP.[no])
from NonGUCianProgressReport NGP
where NGP.thesisSerialNumber = @thesisSerialNo

IF(@thesisSerialNo IN(select G.serialNo
						from GUCianStudentRegisterThesis G))

select @vari = G.[sid], @varic = G.supid
from GUCianStudentRegisterThesis G
where G.serialNo = @thesisSerialNo

ELSE

select @vari = NG.[sid], @varic = NG.supid
from NonGUCianStudentRegisterThesis NG
where NG.serialNo = @thesisSerialNo

IF(@thesisSerialNo IN(select G.serialNo
						from GUCianStudentRegisterThesis G))

insert into GucianProgressReport([sid],[no],[date],thesisSerialNumber,supid) 
values(@vari, (@varib+1), @progressReportDate, @thesisSerialNo, @varic)

ELSE

insert into NonGucianProgressReport([sid],[no],[date],thesisSerialNumber, supid)
values(@vari, (@varib+1), @progressReportDate, @thesisSerialNo, @varic)

-- 6f) fill progress reports
go
create proc FillProgressReport
@thesisSerialNo int,
@progressReportNo int,
@state int, 
@description varchar(200)
AS
IF(@thesisSerialNo IN(select G.serialNo
						from GUCianStudentRegisterThesis G))
update GucianProgressReport
set [state] = @state, [description] = @description
where thesisSerialNumber = @thesisSerialNo and [no] = @progressReportNo

ELSE

update NonGucianProgressReport
set [state] = @state, [description] = @description
where thesisSerialNumber = @thesisSerialNo and [no] = @progressReportNo

-- 6g) view my progress reports' evaluations
go
create proc ViewEvalProgressReport
@thesisSerialNo int,
@progressReportNo int
AS
IF(@thesisSerialNo IN(select G.serialNo
						from GUCianStudentRegisterThesis G))
select P.thesisSerialNumber, P.[no], P.Eval
From GucianProgressReport P
where P.thesisSerialNumber=@thesisSerialNo AND P.[no]=@progressReportNo

ELSE

select P1.thesisSerialNumber, P1.[no], P1.Eval
From NonGUCianProgressReport P1
where P1.thesisSerialNumber=@thesisSerialNo AND P1.[no]=@progressReportNo

-- 6h) add publication
go
create proc addPublication
@title varchar(50), 
@pubDate datetime, 
@host varchar(50), 
@accepted bit,
@place varchar(50)
AS
insert into Publication
values(@title, @pubDate, @place, @accepted, @host)

-- 6i) link publication to my thesis
go
create proc linkPubThesis
@PubID int, 
@thesisSerialNo int
AS
insert into ThesisHasPublication
values(@thesisSerialNo, @PubID)

--------------------------------------------new procedures for milestone 3---------------------------------------------------
go
create proc ExaminerRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@isNational bit,
@fieldofwork varchar(20),
@email varchar(50),
@Success bit output,
@ID int output
AS
declare @vari int
insert into PostGradUser
values(@email, @password)
set @vari = scope_identity()
set @ID = @vari
insert into Examiner
values (@vari, @first_name +' '+@last_name, @fieldofwork,@isNational)

if(@vari in (select ID from Examiner))
set @Success = '1'
else
set @Success = '0'

go
create proc whichStudent
@studentID int,
@guc bit output
AS 
if(@studentID in (select ID from GucianStudent))
set @guc = 1
else
set @guc = 0

go
create proc existsStudent
@studentID int,
@exist bit output
AS 
if(@studentID in (select ID from GucianStudent UNION select ID from NonGucianStudent))
set @exist = 1
else
set @exist = 0

go
create proc existsSupervisor
@supervisorID int,
@exist bit output
AS 
if(@supervisorID in (select ID from Supervisor))
set @exist = 1
else
set @exist = 0
 

go
create proc existsthesis
@thesisSerialNo int,
@exist bit output
AS 
if(@thesisSerialNo in (select serialNumber from Thesis))
set @exist = 1
else
set @exist = 0

go
create proc existsdefense
@thesisSerialNo int,
@exist bit output
AS 
if(@thesisSerialNo in (select serialNumber from Defense))
set @exist = 1
else
set @exist = 0


go
create proc existsprogressreport
@number int,
@thesisSerialNo int,
@exist bit output
AS 
if(@number in (select [no] from GUCianProgressReport where thesisSerialNumber=@thesisSerialNo UNION select [no] from NonGUCianProgressReport where thesisSerialNumber=@thesisSerialNo))
set @exist = 1
else
set @exist = 0

go
create proc StudentsRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@Gucian bit,
@email varchar(50),
@address varchar(50),
@Success bit output,
@ID int output
AS
declare @vari int
insert into PostGradUser
values(@email, @password)
set @vari = scope_identity();
set @ID = @vari
if @Gucian = '1'
insert into GucianStudent(ID, firstName, lastName, faculty, address)
values (@vari, @first_name,@last_name, @faculty,  @address)
else
insert into NonGucianStudent(ID, firstName, lastName, faculty, address)
values (@vari, @first_name,@last_name, @faculty, @address)

if(@vari in (select ID from GucianStudent union select ID from NonGucianStudent))
set @Success = '1'
else
set @Success = '0'

go
create proc SupervisorsRegister
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@faculty varchar(20),
@email varchar(50),
@Success bit output,
@ID int output
AS
declare @vari int
insert into PostGradUser
values(@email, @password)
set @vari = scope_identity()
set @ID = @vari
insert into Supervisor
values (@vari, @first_name +' '+@last_name, @faculty)

if(@vari in (select ID from Supervisor))
set @Success = '1'
else
set @Success = '0'

go
create proc usersLogin
@email varchar(50),
@password varchar(20),
@Success bit output,
@type int output,
@ID int output
AS
Begin
if (EXISTS (select email, [password]
			from PostGradUser
			where email = @email and [password] = @password))
Begin
Set @Success='1'

select @ID = P.ID
from PostGradUser P
where P.email = @email

if exists(select id from GucianStudent where id=@id union select id from
NonGucianStudent where id=@id )
set @type=0
if exists(select id from [Admin] where id=@id)
set @type=1
if exists(select id from Supervisor where id=@id)
set @type=2
if exists(select id from Examiner where id=@id)
set @type=3
END

ELSE

Set @Success='0';
END

go
create proc addMobileNo 
@ID int,
@mobile_number varchar(20),
@Success bit output
AS
if (@ID IN (select ID
			from GucianStudent))
 Insert into GUCStudentPhoneNumber(ID, phone)
 values(@ID, @mobile_number)
 else if(@ID IN (select ID
				from NonGucianStudent))
Insert into NonGUCStudentPhoneNumber(ID, phone)
 values(@ID, @mobile_number)

if exists(select ID,phone from NonGUCStudentPhoneNumber where @ID = ID and @mobile_number = phone union select ID,phone
from GUCStudentPhoneNumber where @ID = ID and @mobile_number = phone)
set @Success = '1'
else
set @Success = '0'

go
create proc AdminsIssueInstallPayment
@paymentID int, 
@InstallStartDate date,
@Success bit output
AS
declare @totalpayment decimal
declare @installment int
declare @installmentamount decimal

if(@InstallStartDate < CURRENT_TIMESTAMP)
set @Success = '0'

else
select @installment = P.no_Installments, @totalpayment = P.amount
from Payment P
where P.ID = @paymentID
set @installmentamount = @totalpayment/@installment
while (@installment > 0)
BEGIN
set @InstallStartDate = dateadd(month,6,@InstallStartDate)
set @installment -= 1;
insert into Installment
values(@InstallStartDate,@paymentID,@installmentamount,'0')
END;
if(@installment = 0)
set @Success = '1'


drop proc AdminsIssueInstallPayment
declare @Success bit
exec AdminsIssueInstallPayment 3, '6/12/2022',@Success output
print @Success

go
create proc AdminsViewOnGoingTheses
@ThesisCount int output
AS
select @ThesisCount = count(*)
from Thesis
where endDate > CURRENT_TIMESTAMP or noExtension > 0

go
create proc AdminsUpdateExtension
@ThesisSerialNo int,
@Success bit output
As
declare @ext int
declare @ext1 int
select @ext = T.noExtension
from Thesis T
where T.serialNumber = @ThesisSerialNo

set @ext += 1

	update Thesis 
	set noExtension=noExtension+1
	where serialNumber = @ThesisSerialNo

select @ext1 = T.noExtension
from Thesis T
where T.serialNumber = @ThesisSerialNo

if(@ext = @ext1)
set @Success = '1'
else
set @Success = '0'

go
create proc ThesisExists
@ThesisSerialNo int,
@Success bit output
AS
if(@ThesisSerialNo IN (select T.serialNumber
						from Thesis T))
set @Success = '1'

else

set @Success = '0'

go
create proc PaymentIdExists
@paymentID int,
@Success bit output
AS
if(@paymentID IN(select P.ID
					from Payment P))
set @Success = '1'

else

set @Success = '0'

go
create proc EditExaminer
@examinerID int,
@examinerName varchar(20),
@examinerfoe varchar(20),
@examineremail varchar(50),
@examinerpassword varchar(20)
AS

update PostGradUser
set email = @examineremail, [password] = @examinerpassword
where ID = @examinerID

update Examiner 
set [name] = @examinerName, fieldOfWork = @examinerfoe
where ID = @examinerID

go
create proc ViewAll
@examinerID int
AS
select T.title as 'ThesisTitle', NG.firstName +' '+ NG.lastName as 'StudentName', Sup.[name] as 'SupervisorName'
from ExaminerEvaluateDefense ED
inner join Thesis T on (ED.serialNo = T.serialNumber)
inner join NonGUCianStudentRegisterThesis NGR on (T.serialNumber = NGR.serialNo)
inner join Supervisor Sup on (NGR.supid = Sup.ID)
inner join NonGucianStudent NG on (NGR.[sid] = NG.ID)
where ED.examinerId = @examinerID

union

select T.title as 'ThesisTitle', G.firstName +' '+ G.lastName as 'StudentName', Sup.[name] as 'SupervisorName'
from ExaminerEvaluateDefense ED
inner join Thesis T on (ED.serialNo = T.serialNumber)
inner join GUCianStudentRegisterThesis GR on (T.serialNumber = GR.serialNo)
inner join Supervisor Sup on (GR.supid = Sup.ID)
inner join GucianStudent G on (GR.[sid] = G.ID)
where ED.examinerId = @examinerID

go
create proc ThesisTitle
@keyword varchar(20),
@Success bit output
AS

select T.*
from Thesis T
where T.title like '%'+@keyword+'%'

if exists(select T.*
from Thesis T
where T.title like '%'+@keyword+'%')

set @Success = '1'

else

set @Success = '0'

go
CREATE proc ViewThesis 
@studentID INT
AS
if(@studentID IN(select G.ID from GucianStudent G))

select T.* 
from GUCianStudentRegisterThesis GT inner join Thesis T ON ( GT.serialNo = T.serialNumber)
where GT.sid= @studentID;

ELSE

select T.*
FROM NonGUCianStudentRegisterThesis NT inner join Thesis T ON (NT.serialNo=T.serialNumber)
where NT.sid=@studentID