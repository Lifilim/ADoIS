#let subj(x) = highlight(fill: rgb("#ffb66c"))[#x]
#let pred(x) = highlight(fill: rgb("#ec9ba4"))[#x]
#let obj(x) = highlight(fill: rgb("#b7b3ca"))[#x]

= #underline[*ШАГ №2 Построить диаграмму классов, указать, каким образом были получены атрибуты, ассоциации и операций из хранимой информации и действий. При разработке модели названия классам следует давать на английском языке, при этом должно быть понятно соответствие между классами и потенциальными классами. Также нужно дать пояснения по выделенным ассоциациям и кратностям их полюсов.*]

*Шаг №2.1 Триплеты*

Основные триплеты (#subj[подлежащее] – #pred[сказуемое (с прямым дополнением)] – #obj[дополнение]):
#[
  #set enum(indent: 0em, numbering: "1.")
  + #subj[Университет] #pred[включает] #obj[Факультет]
  + #subj[Факультет] #pred[включает] #obj[Специальность]
  + #subj[Специальность] #pred[имеет места в] #obj[План набора]
  + #subj[Специальность] #pred[требует сдачи] #obj[Экзамен специальности]
  + #subj[Экзамен специальности] #pred[относится к] #obj[Экзамен]
  + #subj[Абитуриент] #pred[подаёт] #obj[Документы]
  + #subj[Документы] #pred[подаются на] #obj[Специальность]
  + #subj[Университет] #pred[устанавливает] #obj[Срок]
  + #subj[Университет] #pred[назначает дату сдачи] #obj[Экзамен]
  + #subj[Технический секретарь] #pred[регистрирует] #obj[Абитуриент]
  + #subj[Технический секретарь] #pred[сообщает данные для авторизации] #obj[Абитуриент]
  + #subj[Абитуриент] #pred[просматривает расписание] #obj[Экзамен]
  + #subj[Абитуриент] #pred[просматривает] #obj[Результат экзамена]
  + #subj[Абитуриент] #pred[проверяет прохождение по] #obj[Конкурс]
  + #subj[Абитуриент] #pred[переводит Документы на другую] #obj[Специальность]
  + #subj[Абитуриент] #pred[переводит Документы на внебюджет при наличии мест в] #obj[План набора]
  + #subj[Абитуриент] #pred[просматривает] #obj[Зачисление]
  + #subj[Абитуриент] #pred[просматривает проходные баллы и недобор] #obj[Конкурс]
  + #subj[Конкурс] #pred[проводится на] #obj[Специальность]
  + #subj[Конкурс] #pred[допускает после сдачи всех Экзаменов] #obj[Абитуриент]
  + #subj[Результат экзамена] #pred[выставляется по] #obj[Экзамен]
  + #subj[Конкурс] #pred[суммирует баллы] #obj[Результат экзамена]
  + #subj[Конкурс] #pred[оформляет Зачисление для] #obj[Абитуриент]
  + #subj[Конкурс] #pred[занимает места в] #obj[План набора]
  + #subj[Конкурс] #pred[сравнивает баллы по профильному] #obj[Экзамен специальности]
  + #subj[Конкурс] #pred[сравнивает средний балл аттестата] #obj[Абитуриент]
  + #subj[Секретарь приёмной комиссии] #pred[вручную оформляет Зачисление для] #obj[Абитуриент]
  + #subj[Секретарь приёмной комиссии] #pred[вводит причину в] #obj[Зачисление]
  + #subj[Секретарь приёмной комиссии] #pred[перераспределяет места между] #obj[Специальность]
]

*Шаг №2.2 Классы, атрибуты и методы*

#[
  // в ячейках: без абзацных отступов и выравнивания по ширине, длинные идентификаторы
  // (camelCase) могут переноситься, поэтому текст не вылезает за границы ячеек
  #set par(first-line-indent: 0pt, hanging-indent: 0pt, justify: false, leading: 0.5em, spacing: 0.5em)
  #show regex("[a-z][A-Z]"): it => [#it.text.first()#sym.zws#it.text.last()]
  #table(
      columns: (3.9fr, 5.0fr, 8.6fr),
      inset: (x: 4pt, y: 3pt),
      align: left + top,
      stroke: 0.5pt + black,
      fill: (_, y) => if y == 0 { rgb("#e6e6e6") },
      [*Класс*], [*Атрибуты*], [*Методы*],
    [University (Университет)],
    [—],
    [setDeadline(type: _DeadlineType_, startDate: _Date_, endDate: _Date_): _Deadline_ \
    scheduleExam(exam: _Exam_, date: _Date_): _void_],
      [Faculty (Факультет)],
    [name: _String_],
    [—],
      [Specialty (Специальность)],
    [name: _String_],
    [getExams(): _List\<SpecialtyExam\>_ \
    getProfileExam(): _SpecialtyExam_],
      [EnrollmentPlan (План набора)],
    [budgetPlaces: _Integer_ \
    paidPlaces: _Integer_ \
    occupiedBudgetPlaces: _Integer_ \
    occupiedPaidPlaces: _Integer_],
    [getFreePlaces(basis: _StudyBasis_): _Integer_ \
    occupyPlace(basis: _StudyBasis_): _void_ \
    changePlaces(basis: _StudyBasis_, delta: _Integer_): _void_],
      [SpecialtyExam (Экзамен специальности)],
    [isProfile: _Boolean_],
    [—],
      [Exam (Экзамен)],
    [name: _String_ \
    examDate: _Date_],
    [—],
      [Applicant (Абитуриент)],
    [fullName: _String_ \
    averageCertificateScore: _Double_ \
    login: _String_ \
    passwordHash: _String_],
    [submitDocuments(specialty: _Specialty_, basis: _StudyBasis_): _Application_ \
    viewExamSchedule(): _List\<Exam\>_ \
    viewExamResults(): _List\<ExamResult\>_ \
    checkCompetitionStatus(): _Boolean_ \
    transferToSpecialty(newSpecialty: _Specialty_): _void_ \
    transferToPaid(): _void_ \
    viewCompetition(basis: _StudyBasis_): _Competition_ \
    viewEnrollment(): _Enrollment_],
      [Application (Документы)],
    [submissionDate: _Date_ \
    basis: _StudyBasis_],
    [—],
      [Deadline (Срок)],
    [type: _DeadlineType_ \
    startDate: _Date_ \
    endDate: _Date_],
    [—],
      [TechnicalSecretary (Технический секретарь)],
    [—],
    [registerApplicant(fullName: _String_, averageCertificateScore: _Double_): _Applicant_ \
    issueCredentials(applicant: _Applicant_): _void_],
      [ExamResult (Результат экзамена)],
    [score: _Integer_],
    [isPassed(minScore: _Integer_): _Boolean_],
      [Competition (Конкурс)],
    [basis: _StudyBasis_ \
    passingScore: _Integer_ \
    shortfall: _Integer_],
    [isAdmitted(applicant: _Applicant_, minScore: _Integer_): _Boolean_ \
    calculateTotalScore(applicant: _Applicant_): _Integer_ \
    compare(a: _Applicant_, b: _Applicant_): _Integer_ \
    conductEnrollment(minScore: _Integer_): _List\<Enrollment\>_],
      [Enrollment (Зачисление)],
    [isManual: _Boolean_ \
    reason: _String_],
    [—],
      [CommitteeSecretary (Секретарь приёмной комиссии)],
    [—],
    [enrollManually(applicant: _Applicant_, reason: _String_): _Enrollment_ \
    redistributePlaces(source: _Specialty_, target: _Specialty_, basis: _StudyBasis_, count: _Integer_): _void_],
    )
]
/*
*Шаг №2.3 Ассоциации и кратности полюсов*

1\. University [1] — [1..\*] Faculty (“включает” — Агрегация; направление University → Faculty; триплет 1). В университете минимум один факультет; факультет принадлежит одному университету.

2\. Faculty [1] — [1..\*] Specialty (“включает” — Агрегация; направление Faculty → Specialty; триплет 2). Факультет ведёт минимум одну специальность; специальность относится к одному факультету.

3\. Specialty [1] — [1] EnrollmentPlan (“имеет места в” — Композиция; направление Specialty → EnrollmentPlan; триплеты 3, 16, 24, 29). У специальности ровно один план набора, без специальности он не существует. Через него проверяются, занимаются и перераспределяются места.

4\. Specialty [1] — [1..\*] SpecialtyExam (“требует сдачи” — Композиция; направление Specialty → SpecialtyExam; триплеты 4, 25). У специальности минимум один экзамен; запись не существует без специальности, в ней хранится признак профильного.

5\. SpecialtyExam [0..\*] — [1] Exam (“относится к” — Ассоциация; направление SpecialtyExam → Exam; триплет 5). Запись относится ровно к одному экзамену, а один экзамен входит в наборы многих специальностей: это “многие ко многим”, разрешённое классом-связкой.

6\. Applicant [1] — [0..1] Application (“подаёт” — Ассоциация, двунаправленная; триплет 6). Абитуриент подаёт не более одного комплекта документов (при переводе он изменяется); пока документы не поданы, связи нет. У документов ровно один абитуриент.

7\. Application [0..\*] — [1] Specialty (“подаются на” — Ассоциация, двунаправленная; триплеты 7, 15). Документы поданы на одну специальность, на специальность подаётся много документов. При переводе связь переключается на другую специальность.

8\. University [1] — [0..3] Deadline (“устанавливает” — Композиция; направление University → Deadline; триплет 8). Не более трёх сроков: подачи документов, сдачи экзаменов, зачисления; до их установки сроков нет. Срок не существует без университета.

9\. University [1] — [0..\*] Exam (“назначает дату сдачи” — Ассоциация; направление University → Exam; триплет 9). Университет назначает дату каждому экзамену; экзамен относится к одному университету.

10\. TechnicalSecretary [1] — [0..\*] Applicant (“регистрирует” — Ассоциация; направление TechnicalSecretary → Applicant; триплеты 10, 11). Секретарь регистрирует многих абитуриентов и сообщает каждому данные для авторизации; каждый абитуриент зарегистрирован одним секретарём.

11\. Applicant [1] — [0..\*] ExamResult (“имеет результаты” — Композиция; направление Applicant → ExamResult; триплеты 13, 22). Результаты принадлежат абитуриенту, до экзаменов их нет. Абитуриент просматривает свои результаты, а конкурс суммирует по ним баллы.

12\. ExamResult [0..\*] — [1] Exam (“выставляется по” — Ассоциация; направление ExamResult → Exam; триплет 21). Каждый результат выставлен ровно по одному экзамену.

13\. Specialty [1] — [0..2] Competition (“проводится на” — Композиция, двунаправленная; триплеты 14, 18, 19, 20, 22, 24, 25). Конкурс проводится отдельно на бюджет и внебюджет, до проведения его нет. Через специальность конкурс получает документы, план набора и профильный экзамен; показатели факультета и университета не хранятся, а вычисляются.

14\. Competition [0..1] — [0..\*] Enrollment (“оформляет” — Ассоциация; направление Competition → Enrollment; триплет 23). Автоматические зачисления оформляет конкурс; ручное зачисление оформляется без конкурса, поэтому 0..1.

15\. Applicant [1] — [0..1] Enrollment (“зачисляется” — Ассоциация, двунаправленная; триплеты 17, 23, 27). Абитуриент зачисляется не более одного раза; зачисление относится ровно к одному абитуриенту.

16\. CommitteeSecretary [0..1] — [0..\*] Enrollment (“вручную оформляет” — Ассоциация; направление CommitteeSecretary → Enrollment; триплеты 27, 28). Ручное зачисление с указанием причины оформляет секретарь комиссии; автоматическое – без него, поэтому 0..1.

*Зависимости («use»):*

1\. Applicant ⇢ Specialty («use»). Методы «submitDocuments» и «transferToSpecialty» принимают объект «Specialty» (триплеты 6, 15). Изменения класса «Specialty» могут потребовать изменения класса «Applicant».

2\. Applicant ⇢ Exam («use»). Метод «viewExamSchedule» возвращает список объектов «Exam» (триплет 12).

3\. Applicant ⇢ Competition («use»). Метод «viewCompetition» возвращает объект «Competition» (триплеты 14, 18).

4\. Competition ⇢ Applicant («use»). Методы «isAdmitted», «calculateTotalScore» и «compare» принимают объект «Applicant» (триплеты 20, 22, 26).

5\. CommitteeSecretary ⇢ Applicant («use»). Метод «enrollManually» принимает объект «Applicant» (триплет 27).

6\. CommitteeSecretary ⇢ Specialty («use»). Метод «redistributePlaces» принимает объекты «Specialty», между которыми переносятся места (триплет 29).

7\. University ⇢ DeadlineType, Deadline ⇢ DeadlineType («use»). Вид срока задаётся перечислением «DeadlineType» (триплет 8).

8\. Applicant, Application, Competition, EnrollmentPlan, CommitteeSecretary ⇢ StudyBasis («use»). Форма обучения (бюджет / внебюджет) задаётся перечислением «StudyBasis» (триплеты 3, 16, 18, 24, 29).

*/