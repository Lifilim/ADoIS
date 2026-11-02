= #underline[*ШАГ №3 После анализа взаимодействий привести возможно обновленную диаграмму классов.*]

*Шаг №3.1 Диаграмма классов*

/*
```plantuml
@startuml
skinparam classAttributeIconSize 0
skinparam shadowing false
skinparam defaultFontName "Liberation Sans"
hide circle

enum StudyBasis {
  BUDGET
  PAID
}
enum DeadlineType {
  DOCUMENTS
  EXAMS
  ENROLLMENT
}

class University {
  - name: String
  --
  + setDeadline(type: DeadlineType, startDate: Date, endDate: Date): Deadline
  + isDeadlineActive(type: DeadlineType, date: Date): Boolean
  + conductEnrollment(minScore: Integer): void
  + getCompetition(basis: StudyBasis): Competition
  + getEnrolledApplicants(): List<Applicant>
}
class Deadline {
  - type: DeadlineType
  - startDate: Date
  - endDate: Date
  --
  + isActive(date: Date): Boolean
}
class Faculty {
  - name: String
  --
  + conductEnrollment(minScore: Integer): void
  + getCompetition(basis: StudyBasis): Competition
  + getEnrolledApplicants(): List<Applicant>
}
class Specialty {
  - name: String
  --
  + getExams(): List<Exam>
  + getProfileExam(): Exam
  + hasSameExams(other: Specialty): Boolean
  + hasFreePlaces(basis: StudyBasis): Boolean
  + occupyPlace(basis: StudyBasis): void
  + changePlaces(basis: StudyBasis, delta: Integer): void
  + conductCompetition(minScore: Integer): void
  + isPassing(application: Application, minScore: Integer): Boolean
  + getCompetition(basis: StudyBasis): Competition
  + getEnrolledApplicants(): List<Applicant>
}
class EnrollmentPlan {
  - budgetPlaces: Integer
  - paidPlaces: Integer
  - occupiedBudgetPlaces: Integer
  - occupiedPaidPlaces: Integer
  --
  + setPlaces(basis: StudyBasis, places: Integer): void
  + changePlaces(basis: StudyBasis, delta: Integer): void
  + getFreePlaces(basis: StudyBasis): Integer
  + occupyPlace(basis: StudyBasis): void
}
class SpecialtyExam {
  - isProfile: Boolean
  --
  + getExam(): Exam
}
class Exam {
  - name: String
  - examDate: Date
  --
  + assignDate(date: Date): void
}
class Competition {
  - basis: StudyBasis
  - passingScore: Integer
  - applicationsCount: Integer
  - placesCount: Integer
  - shortfall: Integer
  --
  + calculateRatio(): Double
}

class Applicant {
  - fullName: String
  - averageCertificateScore: Double
  - login: String
  - passwordHash: String
  --
  + authenticate(login: String, password: String): Boolean
  + viewExamSchedule(): List<Exam>
  + viewExamResults(): List<ExamResult>
  + checkCompetitionStatus(minScore: Integer): Boolean
  + transferToSpecialty(newSpecialty: Specialty, date: Date): void
  + transferToPaid(date: Date): void
}
class Application {
  - submissionDate: Date
  - basis: StudyBasis
  - totalScore: Integer
  --
  + getExams(): List<Exam>
  + getResults(): List<ExamResult>
  + calculateTotalScore(): Integer
  + getProfileScore(): Integer
  + isAdmitted(minScore: Integer): Boolean
  + compareTo(other: Application): Integer
  + changeSpecialty(newSpecialty: Specialty): void
  + changeBasis(newBasis: StudyBasis): void
}
class ExamResult {
  - score: Integer
  --
  + isPassed(minScore: Integer): Boolean
}
class Enrollment {
  - enrollmentDate: Date
  - isManual: Boolean
  - reason: String
}

abstract class Secretary {
  - fullName: String
  - login: String
  - passwordHash: String
  --
  + authenticate(login: String, password: String): Boolean
}
class TechnicalSecretary {
  + registerApplicant(fullName: String, averageCertificateScore: Double, specialty: Specialty, basis: StudyBasis): Applicant
  + issueCredentials(applicant: Applicant): String
  + enterExamResult(applicant: Applicant, exam: Exam, score: Integer): ExamResult
}
class CommitteeSecretary {
  + scheduleExam(exam: Exam, date: Date): void
  + changeEnrollmentPlan(plan: EnrollmentPlan, basis: StudyBasis, places: Integer): void
  + conductEnrollment(minScore: Integer): void
  + enrollManually(application: Application, reason: String): Enrollment
  + redistributePlaces(source: Specialty, target: Specialty, basis: StudyBasis, count: Integer): void
}


' --- структура вуза
University "1" o--> "1..*" Faculty : включает
Faculty "1" o--> "1..*" Specialty : включает
University "1" *--> "0..3" Deadline : имеет сроки
Specialty "1" *--> "1" EnrollmentPlan : имеет план
Specialty "1" *--> "1..* specialtyExams" SpecialtyExam : требует
SpecialtyExam "0..*" --> "1 exam" Exam : относится к
Specialty "1" *--> "0..2" Competition : имеет

' --- абитуриенты
Applicant "0..*" --> "1" University : поступает в
Applicant "1" <--> "0..1" Application : подаёт / принадлежит
Specialty "1" <--> "0..*" Application : принимает / подана на
Application "1" *--> "0..*" ExamResult : содержит результаты
ExamResult "0..*" --> "1" Exam : получен по
Application "1" --> "0..1" Enrollment : завершается

' --- секретари
Secretary "1..*" --> "1" University : работает в
TechnicalSecretary "1" --> "0..*" Applicant : регистрирует
CommitteeSecretary "0..1" --> "0..*" Enrollment : оформляет вручную
TechnicalSecretary --|> Secretary
CommitteeSecretary --|> Secretary

' --- зависимости (объект передаётся параметром)
Applicant ..> Specialty : <<use>>
TechnicalSecretary ..> Specialty : <<use>>
TechnicalSecretary ..> Exam : <<use>>
CommitteeSecretary ..> Exam : <<use>>
CommitteeSecretary ..> EnrollmentPlan : <<use>>
CommitteeSecretary ..> Application : <<use>>
CommitteeSecretary ..> Specialty : <<use>>
Deadline ..> DeadlineType : <<use>>
Application ..> StudyBasis : <<use>>
Competition ..> StudyBasis : <<use>>
@enduml
```
*/