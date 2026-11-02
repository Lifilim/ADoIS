#let subj(x) = highlight(fill: rgb("#ffb66c"))[#x]
#let pred(x) = highlight(fill: rgb("#ec9ba4"))[#x]
#let obj(x) = highlight(fill: rgb("#b7b3ca"))[#x]

= #underline[*ШАГ №2 Построить диаграмму классов, указать, каким образом были получены атрибуты, ассоциации и операций из хранимой информации и действий. При разработке модели названия классам следует давать на английском языке, при этом должно быть понятно соответствие между классами и потенциальными классами. Также нужно дать пояснения по выделенным ассоциациям и кратностям их полюсов.*]

*Шаг №2.1 Триплеты*
Основные триплеты (#subj[подлежащее] – #pred[сказуемое (с прямым дополнением)] – #obj[дополнение]):
#[
  #set enum(indent: 0em, numbering: "1.")
  + #subj[Университет] #pred[включает в себя] #obj[Факультет]
  + #subj[Факультет] #pred[включает в себя] #obj[Специальность]
  + #subj[Специальность] #pred[имеет план] #obj[План набора]
  // + #subj[План набора] #pred[определяет] #obj[форму обучения]
  + #subj[План набора] #pred[содержит количество] #obj["бюджетные места"]
  + #subj[План набора] #pred[содержит количество] #obj["внебюджетные места"]
  + #subj[Специальность] #pred[требует сдачи] #obj[Экзамен специальности]
  + #subj[Экзамен специальности] #pred[ссылается на] #obj[Экзамен]
  + #subj[Экзамен специальности] #pred[имеет признак] #obj["профильный"]
  + #subj[Экзамен] #pred[имеет дату сдачи] #obj["срок сдачи экзамена"]

 о подаче документов и абитуриентах:

  + #subj[Абитуриент] #pred[подаёт] #obj[Документы]
  + #subj[Документы] #pred[подаются на] #obj[Специальность]
  + #subj[Документы] #pred[имеют срок подачи] #obj["срок подачи документов"]
  + #subj[Абитуриент] #pred[имеет] #obj["средний балл аттестата"]
  + #subj[Технический секретарь] #pred[регистрирует] #obj[Абитуриент]
  + #subj[Технический секретарь] #pred[выдаёт данные для авторизации] #obj[Абитуриент]

 о результатах экзаменов:

  + #subj[Абитуриент] #pred[имеет] #obj[Результат экзамена]
  + #subj[Результат экзамена] #pred[относится к] #obj[Экзамен]
  + #subj[Результат экзамена] #pred[содержит] #obj["экзаменационный балл"]

 о конкурсе и зачислении:

  + #subj[Специальность] #pred[имеет] #obj[Конкурс]
  + #subj[Конкурс] #pred[определяет] #obj["проходной балл"]
  + #subj[Конкурс] #pred[определяет] #obj["недобор"]
  + #subj[Конкурс] #pred[учитывает] #obj[Документы]
  + #subj[Конкурс] #pred[учитывает] #obj[Результат экзамена]
  + #subj[Конкурс] #pred[требует успешной сдачи] #obj["все экзамены не ниже 4 баллов"]
  + #subj[Конкурс] #pred[ранжирует по] #obj["сумма баллов по экзаменам"]
  + #subj[Конкурс] #pred[разрешает спор по] #obj["балл по профильному предмету"]
  + #subj[Конкурс] #pred[разрешает спор по] #obj["средний балл аттестата"]
  + #subj[Абитуриент] #pred[получает] #obj[Зачисление]
  + #subj[Зачисление] #pred[производится на] #obj[Специальность]
  + #subj[Зачисление] #pred[имеет] #obj[форму обучения]
  + #subj[Зачисление] #pred[имеет срок] #obj["срок зачисления"]
  + #subj[Секретарь приёмной комиссии] #pred[производит вручную] #obj[Зачисление]
  + #subj[Зачисление] #pred[имеет] #obj["причина ручного зачисления"]
  + #subj[Секретарь приёмной комиссии] #pred[перераспределяет] #obj[План набора]

 о просмотре информации:

  + #subj[Абитуриент] #pred[просматривает] #obj["расписание экзаменов"]
  + #subj[Абитуриент] #pred[просматривает] #obj[Результат экзамена]
  + #subj[Абитуриент] #pred[просматривает] #obj[Конкурс]
  + #subj[Абитуриент] #pred[переводится на] #obj[Специальность]
  + #subj[Абитуриент] #pred[переводится на] #obj[форму обучения]
  + #subj[Абитуриент] #pred[просматривает] #obj[Зачисление]
  + #subj[Абитуриент] #pred[просматривает] #obj["проходной балл"]

 об агрегации конкурса по уровням:
  + #subj[Конкурс] #pred[рассчитывается для] #obj[Специальность]
  + #subj[Конкурс] #pred[включает конкурс специальностей для] #obj[Факультет]
  + #subj[Конкурс] #pred[включает конкурс факультетов для] #obj[Университет]
]

*Шаг №2.2 Классы, атрибуты и методы*

#[
  #set par(first-line-indent: 0pt, hanging-indent: 0pt, justify: false, leading: 0.5em, spacing: 0.5em)
  #show regex("[a-z][A-Z]"): it => [#it.text.first()#sym.zws#it.text.last()]
  #table(
      columns: (3.9fr, 5.0fr, 8.6fr),
      inset: (x: 4pt, y: 3pt),
      align: left + top,
      stroke: 0.5pt + black,
      fill: (_, y) => if y == 0 { rgb("#e6e6e6") },
      [*Класс*], [*Атрибуты*], [*Методы*],

      [University (Университет) < CompetitionAnalyzable],
      [name: _String_ \
      faculties: _List\<Faculty\>_],
      [getFaculties(): _List\<Faculty\>_ \
      addFaculty(faculty: _Faculty_): _void_ \
      getFacultyByName(name: _String_): _Faculty_ \
      getCompetitionSummary(): _CompetitionSummary_ \
      getShortfall(): _Places_ \
      getPassingScore(): _int_ \
      getTotalParticipants(): _int_],

      [Faculty (Факультет) < CompetitionAnalyzable],
      [name: _String_ \
      university: _University_ \
      specialities: _List\<Speciality\>_],
      [getSpecialities(): _List\<Speciality\>_ \
      addSpeciality(s: _Speciality_): _void_ \
      getCompetitionSummary(): _CompetitionSummary_ \
      getShortfall(): _Places_ \
      getPassingScore(): _int_ \
      getTotalParticipants(): _int_],

      [Speciality (Специальность) < CompetitionAnalyzable],
      [code: _String_ \
      name: _String_ \
      faculty: _Faculty_ \
      plan: _Places_ \
      exams: _List\<SpecialityExam\>_ \
      competition: _Competition_],
      [getPlan(): _Places_ \
      getExams(): _List\<SpecialityExam\>_ \
      addExam(se: _SpecialityExam_): _void_ \
      getCompetition(): _Competition_ \
      getShortfall(): _Places_ \
      getPassingScore(): _int_ \
      getTotalParticipants(): _int_ \
      isProfileExam(e: _Exam_): _boolean_ \
      hasSameExams(other: _Speciality_): _boolean_],

      [Places (Количество мест)],
      [year: _int_ \
      budget: _int_ \
      paid: _int_],
      [getBudget(): _int_ \
      getPaid(): _int_ \
      setBudget(n: _int_): _void_ \
      setPaid(n: _int_): _void_ \
      getFreeBudget(): _int_ \
      getFreePaid(): _int_ \
      minus(other: _Places_): _Places_],

      [Exam (Экзамен)],
      [name: _String_ \
      examDate: _Date_],
      [getName(): _String_ \
      getDate(): _Date_ \
      setDate(d: _Date_): _void_],

      [SpecialityExam (Экзамен специальности)],
      [speciality: _Speciality_ \
      exam: _Exam_ \
      isProfile: _boolean_],
      [getExam(): _Exam_ \
      isProfile(): _boolean_ \
      setProfile(flag: _boolean_): _void_],

      [Abiturient (Абитуриент)],
      [fullName: _String_ \
      averageMark: _double_ \
      documents: _List\<Documents\>_ \
      results: _List\<ExamResult\>_],
      [getDocuments(): _List\<Documents\>_ \
      submitDocuments(s: _Speciality_): _Documents_ \
      withdrawDocuments(d: _Documents_): _void_ \
      getResults(): _List\<ExamResult\>_ \
      addResult(r: _ExamResult_): _void_ \
      getTotalScore(s: _Speciality_): _int_ \
      getProfileScore(s: _Speciality_): _int_ \
      isEligible(s: _Speciality_): _boolean_ \
      getCompetitionStatus(s: _Speciality_, basis: _StudyBasis_): _CompetitionStatus_ \
      getRank(s: _Speciality_, basis: _StudyBasis_): _int_ \
      transferTo(s: _Speciality_): _void_ \
      transferToPaid(s: _Speciality_): _void_],

      [Documents (Документы / заявление)],
      [abiturient: _Abiturient_ \
      speciality: _Speciality_ \
      submissionDate: _Date_ \
      submissionDeadline: _Date_ \
      status: _DocumentStatus_],
      [getAbiturient(): _Abiturient_ \
      getSpeciality(): _Speciality_ \
      getSubmissionDate(): _Date_ \
      isSubmittedInTime(): _boolean_ \
      setStatus(s: _DocumentStatus_): _void_ \
      getStatus(): _DocumentStatus_ \
      isAccepted(): _boolean_],

      [ExamResult (Результат экзамена)],
      [abiturient: _Abiturient_ \
      exam: _Exam_ \
      score: _int_],
      [getAbiturient(): _Abiturient_ \
      getExam(): _Exam_ \
      getScore(): _int_ \
      setScore(v: _int_): _void_ \
      isPassed(): _boolean_],

      [Enrollment (Зачисление)],
      [abiturient: _Abiturient_ \
      speciality: _Speciality_ \
      studyBasis: _StudyBasis_ \
      enrollmentDate: _Date_ \
      enrollmentDeadline: _Date_ \
      isManual: _boolean_ \
      reason: _String_],
      [getAbiturient(): _Abiturient_ \
      getSpeciality(): _Speciality_ \
      getStudyBasis(): _StudyBasis_ \
      isManual(): _boolean_ \
      getReason(): _String_ \
      isWithinDeadline(): _boolean_],

      [Competition (Конкурс специальности) < CompetitionAnalyzable],
      [speciality: _Speciality_ \
      studyBasis: _StudyBasis_ \
      participants: _List\<Documents\>_ \
      /passingScore: _int_ \
      /shortfall: _Places_],
      [getSpeciality(): _Speciality_ \
      getStudyBasis(): _StudyBasis_ \
      getParticipants(): _List\<Documents\>_ \
      getPassingScore(): _int_ \
      getShortfall(): _Places_ \
      getTotalParticipants(): _int_ \
      getStatusFor(a: _Abiturient_): _CompetitionStatus_ \
      getRankOf(a: _Abiturient_): _int_ \
      rankParticipants(): _List\<Documents\>_ \
      calculatePassingScore(): _int_ \
      calculateShortfall(): _Places_ \
      resolveTie(a: _Abiturient_, b: _Abiturient_): _Abiturient_ \
      isEligible(a: _Abiturient_): _boolean_],

      [CompetitionSummary (Сводка конкурса по уровню) < CompetitionAnalyzable],
      [level: _AggregationLevel_ \
      children: _List\<Competition\>_ \
      /totalParticipants: _int_ \
      /totalPassingScore: _int_ \
      /totalShortfall: _Places_],
      [getLevel(): _AggregationLevel_ \
      getChildren(): _List\<Competition\>_ \
      getPassingScore(): _int_ \
      getShortfall(): _Places_ \
      getTotalParticipants(): _int_ \
      calculatePassingScore(): _int_ \
      calculateShortfall(): _Places_ \
      calculateTotalParticipants(): _int_],

      [TechnicalSecretary (Технический секретарь)],
      [fullName: _String_],
      [registerAbiturient(a: _Abiturient_): _void_ \
      issueCredentials(a: _Abiturient_): _Credentials_ \
      getCredentialsOf(a: _Abiturient_): _Credentials_],

      [AdmissionSecretary (Секретарь приёмной комиссии)],
      [fullName: _String_],
      [manualEnroll(a: _Abiturient_, s: _Speciality_, basis: _StudyBasis_, reason: _String_): _Enrollment_ \
      redistributePlaces(from: _Places_, to: _Places_, n: _int_): _void_ \
      publishEnrollmentResults(s: _Speciality_): _void_],

      [Credentials (Учётные данные) _value object_],
      [userId: _Long_ \
      login: _String_ \
      password: _String_],
      [getUserId(): _Long_ \
      getLogin(): _String_ \
      getPassword(): _String_ \
      regeneratePassword(): _String_],
    )
]
#[
  #set par(first-line-indent: 0pt, hanging-indent: 0pt, justify: false, leading: 0.5em, spacing: 0.5em)
  #show regex("[a-z][A-Z]"): it => [#it.text.first()#sym.zws#it.text.last()]
  #table(
      columns: (3.9fr, 5.0fr, 8.6fr),
      inset: (x: 4pt, y: 3pt),
      align: left + top,
      stroke: 0.5pt + black,
      fill: (_, y) => if y == 0 { rgb("#e6e6e6") },
      [*Интерфейс*], [*Методы*], [*Реализуют*],

      [CompetitionAnalyzable],
      [getShortfall(): _Places_ \
      getPassingScore(): _int_ \
      getTotalParticipants(): _int_],
      [University, Faculty, Speciality, Competition, CompetitionSummary],
    )
]
#table(
  columns: (4.40fr, 4.40fr, 6.40fr),
  inset: 5pt,
  stroke: 0.5pt + black,
  fill: (_, y) => if y == 0 { rgb("#e6e6e6") },
  [*Перечисление*],
  [*Значения*],
  [*Откуда выделено*],
  [StudyBasis (форма обучения)],
      [BUDGET \
      PAID],
  [Существительные “бюджет”, “внебюджет” – два значения одной характеристики],
  [DocumentStatus (статус заявления)],
      [SUBMITTED \
      ACCEPTED \
      WITHDRAWN \
      TRANSFERRED \
      ENROLLED],
  [Жизненный цикл заявления: подано, принято, отозвано, переведено, зачислено],
  [CompetitionStatus (результат конкурса)],
      [NOT_ELIGIBLE \
      NOT_PASSING \
      PASSING_BUDGET \
      PASSING_PAID \
      ENROLLED_BUDGET \
      ENROLLED_PAID],
  [Результат участия абитуриента в конкурсе],
  [AggregationLevel (уровень агрегации)],
      [FACULTY \
      UNIVERSITY],
  [Уровень сводки конкурса],
)

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