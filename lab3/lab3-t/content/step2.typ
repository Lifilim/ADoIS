= #underline[*ШАГ №2 Построить диаграмму классов, указать, каким образом были получены атрибуты, ассоциации и операций из хранимой информации и действий. При разработке модели названия классам следует давать на английском языке, при этом должно быть понятно соответствие между классами и потенциальными классами. Также нужно дать пояснения по выделенным ассоциациям и кратностям их полюсов.*]

*Шаг №2.1 Классы, атрибуты и методы*

#table(
  columns: (3.60fr, 4.40fr, 9.00fr),
  inset: 5pt,
  stroke: 0.5pt + black,
  fill: (_, y) => if y == 0 { rgb("#e6e6e6") },
  [*Класс*],
  [*Атрибуты*],
  [*Методы*],
  [Университет (University)],
  [_name: String_],
  [_setDeadline(type: DeadlineType, startDate: Date, endDate: Date): Deadline_

    _isDeadlineActive(type: DeadlineType, date: Date): Boolean_

    _conductEnrollment(minScore: Integer): void_

    _getCompetition(basis: StudyBasis): Competition_

    _getEnrolledApplicants(): List\<Applicant\>_],
  [Срок (Deadline)],
  [_type: DeadlineType_

    _startDate: Date_

    _endDate: Date_],
  [_isActive(date: Date): Boolean_],
  [Факультет (Faculty)],
  [_name: String_],
  [_conductEnrollment(minScore: Integer): void_

    _getCompetition(basis: StudyBasis): Competition_

    _getEnrolledApplicants(): List\<Applicant\>_],
  [Специальность (Specialty)],
  [_name: String_],
  [_getExams(): List\<Exam\>_

    _getProfileExam(): Exam_

    _hasSameExams(other: Specialty): Boolean_

    _hasFreePlaces(basis: StudyBasis): Boolean_

    _occupyPlace(basis: StudyBasis): void_

    _changePlaces(basis: StudyBasis, delta: Integer): void_

    _conductCompetition(minScore: Integer): void_

    _isPassing(application: Application, minScore: Integer): Boolean_

    _getCompetition(basis: StudyBasis): Competition_

    _getEnrolledApplicants(): List\<Applicant\>_],
  [План набора (EnrollmentPlan)],
  [_budgetPlaces: Integer_

    _paidPlaces: Integer_

    _occupiedBudgetPlaces: Integer_

    _occupiedPaidPlaces: Integer_],
  [_setPlaces(basis: StudyBasis, places: Integer): void_

    _changePlaces(basis: StudyBasis, delta: Integer): void_

    _getFreePlaces(basis: StudyBasis): Integer_

    _occupyPlace(basis: StudyBasis): void_],
  [Экзамен специальности (SpecialtyExam)],
  [_isProfile: Boolean_],
  [_getExam(): Exam_],
  [Экзамен (Exam)],
  [_name: String_

    _examDate: Date_],
  [_assignDate(date: Date): void_],
  [Конкурс (Competition)],
  [_basis: StudyBasis_

    _passingScore: Integer_

    _applicationsCount: Integer_

    _placesCount: Integer_

    _shortfall: Integer_],
  [_calculateRatio(): Double_],
  [Абитуриент (Applicant)],
  [_fullName: String_

    _averageCertificateScore: Double_

    _login: String_

    _passwordHash: String_],
  [_authenticate(login: String, password: String): Boolean_

    _viewExamSchedule(): List\<Exam\>_

    _viewExamResults(): List\<ExamResult\>_

    _checkCompetitionStatus(minScore: Integer): Boolean_

    _transferToSpecialty(newSpecialty: Specialty, date: Date): void_

    _transferToPaid(date: Date): void_],
  [Документы (Application)],
  [_submissionDate: Date_

    _basis: StudyBasis_

    _totalScore: Integer_],
  [_getExams(): List\<Exam\>_

    _getResults(): List\<ExamResult\>_

    _calculateTotalScore(): Integer_

    _getProfileScore(): Integer_

    _isAdmitted(minScore: Integer): Boolean_

    _compareTo(other: Application): Integer_

    _changeSpecialty(newSpecialty: Specialty): void_

    _changeBasis(newBasis: StudyBasis): void_],
  [Результат экзамена (ExamResult)],
  [_score: Integer_],
  [_isPassed(minScore: Integer): Boolean_],
  [Зачисление (Enrollment)],
  [_enrollmentDate: Date_

    _isManual: Boolean_

    _reason: String_],
  [_—_],
  [Секретарь (Secretary), абстрактный],
  [_fullName: String_

    _login: String_

    _passwordHash: String_],
  [_authenticate(login: String, password: String): Boolean_],
  [Технический секретарь (TechnicalSecretary)],
  [_—_],
  [_registerApplicant(fullName: String, averageCertificateScore: Double, specialty: Specialty, basis: StudyBasis): Applicant_

    _issueCredentials(applicant: Applicant): String_

    _enterExamResult(applicant: Applicant, exam: Exam, score: Integer): ExamResult_],
  [Секретарь приёмной комиссии (CommitteeSecretary)],
  [_—_],
  [_scheduleExam(exam: Exam, date: Date): void_

    _changeEnrollmentPlan(plan: EnrollmentPlan, basis: StudyBasis, places: Integer): void_

    _conductEnrollment(minScore: Integer): void_

    _enrollManually(application: Application, reason: String): Enrollment_

    _redistributePlaces(source: Specialty, target: Specialty, basis: StudyBasis, count: Integer): void_],
)

*Шаг №2.2 Ассоциации и кратности полюсов*

1\. University [1] — [1..\*] Faculty (“включает” — Агрегация; направление University → Faculty). В университете минимум один факультет; факультет принадлежит одному университету.

2\. Faculty [1] — [1..\*] Specialty (“включает” — Агрегация; направление Faculty → Specialty). Факультет ведёт минимум одну специальность; специальность относится к одному факультету.

3\. University [1] — [0..3] Deadline (“имеет сроки” — Композиция; направление University → Deadline). Не более трёх сроков: подачи документов, сдачи экзаменов, зачисления; до их установки сроков нет. Срок не существует без университета.

4\. Specialty [1] — [1] EnrollmentPlan (“имеет план” — Композиция; направление Specialty → EnrollmentPlan). У специальности ровно один план набора; в нём же хранятся занятые места, их число растёт при принятии абитуриента.

5\. Specialty [1] — [1..\*] SpecialtyExam (“требует” — Композиция; направление Specialty → SpecialtyExam; роль specialtyExams). У специальности минимум один экзамен; запись не существует без специальности.

6\. SpecialtyExam [0..\*] — [1] Exam (“относится к” — Ассоциация; направление SpecialtyExam → Exam; роль exam). Запись относится ровно к одному экзамену, а один экзамен входит в наборы многих специальностей. Вместе с предыдущей связью это “многие ко многим”, разрешённое классом-связкой, где хранится признак профильного предмета.

7\. Specialty [1] — [0..2] Competition (“имеет” — Композиция; направление Specialty → Competition). Конкурс хранится отдельно для бюджета и внебюджета; до проведения зачисления его нет. Показатели факультета и университета не хранятся, а вычисляются.

8\. Applicant [0..\*] — [1] University (“поступает в” — Ассоциация; направление Applicant → University). Абитуриент поступает в один университет; через эту связь он проверяет сроки и смотрит итоги.

9\. Applicant [1] — [0..1] Application (“подаёт / принадлежит” — Ассоциация, двунаправленная; Applicant ↔ Application). У абитуриента не более одного заявления; при переводе оно изменяется, а не создаётся заново. Заявлению нужен средний балл аттестата абитуриента.

10\. Specialty [1] — [0..\*] Application (“принимает / подана на” — Ассоциация, двунаправленная; Specialty ↔ Application). На специальность подаётся много заявлений; заявление относится к одной специальности. Специальность перебирает свои заявления при конкурсе, заявление обращается к своей специальности.

11\. Application [1] — [0..\*] ExamResult (“содержит результаты” — Композиция; направление Application → ExamResult). Результаты принадлежат заявлению, поэтому сумма баллов считается внутри Application; до экзаменов результатов нет.

12\. ExamResult [0..\*] — [1] Exam (“получен по” — Ассоциация; направление ExamResult → Exam). Каждый результат получен ровно по одному экзамену.

13\. Application [1] — [0..1] Enrollment (“завершается” — Ассоциация; направление Application → Enrollment). Зачисление есть не у каждого заявления.

14\. Secretary [1..\*] — [1] University (“работает в” — Ассоциация; направление Secretary → University). Секретари работают в одном университете.

15\. TechnicalSecretary [1] — [0..\*] Applicant (“регистрирует” — Ассоциация; направление TechnicalSecretary → Applicant). Секретарь регистрирует многих абитуриентов; каждый зарегистрирован одним секретарём.

16\. CommitteeSecretary [0..1] — [0..\*] Enrollment (“оформляет вручную” — Ассоциация; направление CommitteeSecretary → Enrollment). Ручное зачисление оформляет секретарь комиссии; автоматическое – без секретаря, поэтому 0..1.

Обобщение: TechnicalSecretary и CommitteeSecretary наследуют абстрактный класс Secretary (общие атрибуты и метод authenticate).

*Зависимости («use»):*

1\. Applicant ⇢ Specialty («use»). Метод «transferToSpecialty» переводит абитуриента на другую специальность; параметром для метода является объект «Specialty». Таким образом, изменения, внесённые в класс «Specialty», могут потребовать и изменения класса «Applicant».

2\. TechnicalSecretary ⇢ Specialty («use»). Метод «registerApplicant» регистрирует абитуриента на выбранную специальность; параметром для метода является объект «Specialty». Таким образом, изменения, внесённые в класс «Specialty», могут потребовать и изменения класса «TechnicalSecretary».

3\. TechnicalSecretary ⇢ Exam («use»). Метод «enterExamResult» вводит результат по экзамену; параметром для метода является объект «Exam». Таким образом, изменения, внесённые в класс «Exam», могут потребовать и изменения класса «TechnicalSecretary».

4\. CommitteeSecretary ⇢ Exam («use»). Метод «scheduleExam» назначает дату сдачи экзамена; параметром для метода является объект «Exam». Таким образом, изменения, внесённые в класс «Exam», могут потребовать и изменения класса «CommitteeSecretary».

5\. CommitteeSecretary ⇢ EnrollmentPlan («use»). Метод «changeEnrollmentPlan» изменяет число мест в плане набора; параметром для метода является объект «EnrollmentPlan». Таким образом, изменения, внесённые в класс «EnrollmentPlan», могут потребовать и изменения класса «CommitteeSecretary».

6\. CommitteeSecretary ⇢ Application («use»). Метод «enrollManually» зачисляет абитуриента вручную; параметром для метода является объект «Application». Таким образом, изменения, внесённые в класс «Application», могут потребовать и изменения класса «CommitteeSecretary».

7\. CommitteeSecretary ⇢ Specialty («use»). Метод «redistributePlaces» перераспределяет места между специальностями; параметрами для метода являются два объекта «Specialty». Таким образом, изменения, внесённые в класс «Specialty», могут потребовать и изменения класса «CommitteeSecretary».

8\. Deadline ⇢ DeadlineType («use»). Атрибут «type» имеет тип перечисления «DeadlineType»; изменение значений перечисления может потребовать изменения класса «Deadline».

9\. Application ⇢ StudyBasis («use»). Атрибут «basis» имеет тип перечисления «StudyBasis»; изменение значений перечисления может потребовать изменения класса «Application».

10\. Competition ⇢ StudyBasis («use»). Атрибут «basis» имеет тип перечисления «StudyBasis»; изменение значений перечисления может потребовать изменения класса «Competition».
