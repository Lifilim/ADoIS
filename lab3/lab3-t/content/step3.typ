= #underline[*ШАГ №3 После анализа взаимодействий привести возможно обновленную диаграмму классов.*]

*Шаг №3.1 Диаграмма классов*

#image("/assets/lab3.drawio.png")


/*
```plantuml
@startuml
left to right direction
skinparam linetype ortho
skinparam classAttributeIconSize 1
skinparam nodesep 50
skinparam ranksep 60
skinparam padding 4
skinparam shadowing false
skinparam class {
  BackgroundColor #FFFFFF
  BorderColor #333333
  ArrowColor #555555
}
skinparam package {
  BackgroundColor #F7F7F7
  BorderColor #BBBBBB
  FontStyle bold
}
hide empty members

' ============ ПЕРЕЧИСЛЕНИЯ ============
enum StudyBasis {
  BUDGET
  PAID
}

enum DocumentStatus {
  SUBMITTED
  ACCEPTED
  WITHDRAWN
  TRANSFERRED
  ENROLLED
}

enum CompetitionStatus {
  NOT_ELIGIBLE
  NOT_PASSING
  PASSING_BUDGET
  PASSING_PAID
  ENROLLED_BUDGET
  ENROLLED_PAID
}

enum AggregationLevel {
  FACULTY
  UNIVERSITY
}

' ============ ИНТЕРФЕЙС ============
interface CompetitionAnalyzable {
  + getShortfall(): Places
  + getPassingScore(): int
  + getTotalParticipants(): int
}

' ============ АККАУНТЫ ============
abstract class Account {
  + userId: Long
  + login: String
  + password: String
  + getUserId(): Long
  + getLogin(): String
  + getPassword(): String
  + regeneratePassword(): String
}

class TechnicalSecretary {
  + fullName: String
  + registerAbiturient(fullName: String, averageMark: double): Abiturient
}

class AdmissionSecretary {
  + fullName: String
  + manualEnroll(a: Abiturient, s: Speciality, basis: StudyBasis, reason: String): Enrollment
  + redistributePlaces(from: Places, to: Places, n: int): void
  + publishEnrollmentResults(s: Speciality): void
}

class Abiturient {
  + fullName: String
  + averageMark: double
  + documents: List<Documents>
  + results: List<ExamResult>
  + getDocuments(): List<Documents>
  + submitDocuments(s: Speciality): Documents
  + withdrawDocuments(d: Documents): void
  + getResults(): List<ExamResult>
  + addResult(r: ExamResult): void
  + getTotalScore(s: Speciality): int
  + getProfileScore(s: Speciality): int
  + isEligible(s: Speciality): boolean
  + getCompetitionStatus(s: Speciality, basis: StudyBasis): CompetitionStatus
  + getRank(s: Speciality, basis: StudyBasis): int
  + transferTo(s: Speciality): void
  + transferToPaid(s: Speciality): void
}

Account <|-- TechnicalSecretary
Account <|-- AdmissionSecretary
Account <|-- Abiturient

' ============ СТРУКТУРА УНИВЕРСИТЕТА ============
class University {
  + name: String
  + faculties: List<Faculty>
  + getFaculties(): List<Faculty>
  + addFaculty(faculty: Faculty): void
  + getFacultyByName(name: String): Faculty
  + getCompetitionSummary(): CompetitionSummary
  + getShortfall(): Places
  + getPassingScore(): int
  + getTotalParticipants(): int
}

class Faculty {
  + name: String
  + university: University
  + specialities: List<Speciality>
  + getSpecialities(): List<Speciality>
  + addSpeciality(s: Speciality): void
  + getCompetitionSummary(): CompetitionSummary
  + getShortfall(): Places
  + getPassingScore(): int
  + getTotalParticipants(): int
}

class Speciality {
  + code: String
  + name: String
  + faculty: Faculty
  + plan: Places
  + exams: List<SpecialityExam>
  + competition: Competition
  + getPlan(): Places
  + getExams(): List<SpecialityExam>
  + addExam(se: SpecialityExam): void
  + getCompetition(): Competition
  + getShortfall(): Places
  + getPassingScore(): int
  + getTotalParticipants(): int
  + isProfileExam(e: Exam): boolean
  + hasSameExams(other: Speciality): boolean
}

University "1" *-- "*" Faculty : faculties >
Faculty "1" *-- "*" Speciality : specialities >

' ============ МЕСТА / ЭКЗАМЕНЫ ============
class Places {
  + year: int
  + budget: int
  + paid: int
  + getBudget(): int
  + getPaid(): int
  + setBudget(n: int): void
  + setPaid(n: int): void
  + getFreeBudget(): int
  + getFreePaid(): int
  + minus(other: Places): Places
}

class Exam {
  + name: String
  + examDate: Date
  + getName(): String
  + getDate(): Date
  + setDate(d: Date): void
}

class SpecialityExam {
  + speciality: Speciality
  + exam: Exam
  + isProfile: boolean
  + getExam(): Exam
  + isProfile(): boolean
  + setProfile(flag: boolean): void
}

Speciality "1" *-- "1" Places : plan >
Speciality "1" *-- "*" SpecialityExam : exams >
SpecialityExam "*" --> "1" Exam : exam >
SpecialityExam "*" --> "1" Speciality : speciality >

' ============ ДОКУМЕНТЫ И РЕЗУЛЬТАТЫ ============
class Documents {
  + abiturient: Abiturient
  + speciality: Speciality
  + submissionDate: Date
  + submissionDeadline: Date
  + status: DocumentStatus
  + getAbiturient(): Abiturient
  + getSpeciality(): Speciality
  + getSubmissionDate(): Date
  + isSubmittedInTime(): boolean
  + setStatus(s: DocumentStatus): void
  + getStatus(): DocumentStatus
  + isAccepted(): boolean
}

class ExamResult {
  + abiturient: Abiturient
  + exam: Exam
  + score: int
  + getAbiturient(): Abiturient
  + getExam(): Exam
  + getScore(): int
  + setScore(v: int): void
  + isPassed(): boolean
}

Abiturient "1" *-- "*" Documents : documents >
Documents "*" --> "1" Speciality : speciality >
Abiturient "1" *-- "*" ExamResult : results >
ExamResult "*" --> "1" Exam : exam >

' ============ КОНКУРС ============
class Competition {
  + speciality: Speciality
  + studyBasis: StudyBasis
  + participants: List<Documents>
  + /passingScore: int
  + /shortfall: Places
  + getSpeciality(): Speciality
  + getStudyBasis(): StudyBasis
  + getParticipants(): List<Documents>
  + getPassingScore(): int
  + getShortfall(): Places
  + getTotalParticipants(): int
  + getStatusFor(a: Abiturient): CompetitionStatus
  + getRankOf(a: Abiturient): int
  + rankParticipants(): List<Documents>
  + calculatePassingScore(): int
  + calculateShortfall(): Places
  + resolveTie(a: Abiturient, b: Abiturient): Abiturient
  + isEligible(a: Abiturient): boolean
}

class CompetitionSummary {
  + level: AggregationLevel
  + children: List<Competition>
  + /totalParticipants: int
  + /totalPassingScore: int
  + /totalShortfall: Places
  + getLevel(): AggregationLevel
  + getChildren(): List<Competition>
  + getPassingScore(): int
  + getShortfall(): Places
  + getTotalParticipants(): int
  + calculatePassingScore(): int
  + calculateShortfall(): Places
  + calculateTotalParticipants(): int
}

Speciality "1" *-- "2" Competition : competition >
Competition "*" --> "1" Speciality : speciality >
Competition "*" --> "1" StudyBasis : studyBasis >
Competition "*" o-- "*" Documents : participants >

CompetitionSummary "1" *-- "*" Competition : children >

' ============ ЗАЧИСЛЕНИЕ ============
class Enrollment {
  + abiturient: Abiturient
  + speciality: Speciality
  + studyBasis: StudyBasis
  + enrollmentDate: Date
  + enrollmentDeadline: Date
  + isManual: boolean
  + reason: String
  + getAbiturient(): Abiturient
  + getSpeciality(): Speciality
  + getStudyBasis(): StudyBasis
  + isManual(): boolean
  + getReason(): String
  + isWithinDeadline(): boolean
}

Enrollment "*" --> "1" Abiturient : abiturient >
Enrollment "*" --> "1" Speciality : speciality >
Enrollment "*" --> "1" StudyBasis : studyBasis >

' ============ РЕАЛИЗАЦИЯ ИНТЕРФЕЙСА ============
CompetitionAnalyzable <|.. University
CompetitionAnalyzable <|.. Faculty
CompetitionAnalyzable <|.. Speciality
CompetitionAnalyzable <|.. Competition
CompetitionAnalyzable <|.. CompetitionSummary

@enduml
```
*/