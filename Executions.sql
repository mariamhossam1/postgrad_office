exec StudentRegister 'marco', 'polo', '1234567', 'met', '1', 'gucian@guc.edu.eg', 'shorouk'

exec SupervisorRegister 'alex', 'turner', '123454', 'design and production', 'alex.turner@guc.edu.eg'

declare @success bit
exec userLogin 7, '123456', @success output
print @success

declare @success bit
exec userLogin 7, '12345', @success output
print @success

exec addMobile 1, '102932082'

exec AdminListSup

exec AdminViewSupervisorProfile 36

exec AdminViewAllTheses

declare @thesisCount int 
exec AdminViewOnGoingTheses @thesisCount output
print @thesisCount

exec AdminViewStudentThesisBySupervisor

exec AdminListNonGucianCourse 2

exec AdminUpdateExtension 23

declare @success bit
exec AdminIssueThesisPayment 24,60000,2,50,@success output
print @success

exec AdminViewStudentProfile 30 --nongucian
exec AdminViewStudentProfile 7 --gucian

exec AdminIssueInstallPayment 1, '12/16/2021'

exec AdminListAcceptPublication

exec AddCourse 'CSEN501',4,60000

exec linkCourseStudent 6,17

exec addStudentCourseGrade 6,17,80

exec ViewExamSupDefense '3/15/2021'

exec EvaluateProgressReport 36, 1, 1, 3 --gucian
exec EvaluateProgressReport 36, 18, 1, 3 --nongucian

exec ViewSupStudentsYears 36

exec SupViewProfile 36

exec UpdateSupProfile 36,'Maria','met'

exec ViewAStudentPublications 1

exec AddDefenseGucian 30,'03/15/2021','Egypt'

exec AddDefenseNonGucian 18,'03/15/2021','Egypt'

exec AddExaminer 1,'03/15/2021','rami malek',0,'engineering'

exec CancelThesis 20

exec AddGrade 1,50

exec AddDefenseGrade 18, '03/15/2021', 25

exec AddCommentsGrade 18, '03/15/2021', 'very good'

exec viewMyProfile '1'

exec editMyProfile 3,'ryan','reynolds','123456','gucianstudent@guc.edu.eg','zamalek', 'PHD'

exec addUndergradID '1', '1234'

exec ViewCoursesGrades '25'

exec ViewCoursePaymentsInstall '25'
exec ViewCoursePaymentsInstall '2'

exec ViewThesisPaymentsInstall '30'
exec ViewThesisPaymentsInstall '9'

exec ViewUpcomingInstallments '19' --nongucian
exec ViewUpcomingInstallments '1' --gucian

exec ViewMissedInstallments '16' --nongucian
exec ViewMissedInstallments '15' --gucian

exec  AddProgressReport 1,'12/16/2021' --gucian
exec  AddProgressReport 18,'12/16/2021' --nongucian

exec FillProgressReport 1, 3, 5, 'good'

exec ViewEvalProgressReport '11','1' --gucian
exec ViewEvalProgressReport '21','1' --nongucian

exec addPublication 'nnn','12/8/2021','save the seas','0','cairo'

exec linkPubThesis 3,6