= #underline[*ШАГ №6 В некоторых случаях объекты предметной области обладают собственным поведением. Для описания их поведения следует составить диаграмму состояний. Важно показать состояния, события и условия переходов.*]

Собственное поведение у двух объектов: заявления абитуриента и срока. Состояния не являются значениями перечисления, поэтому записаны по-русски строчными буквами; на стрелках указаны методы-события и условия.

*Шаг №6.1 Диаграмма состояний заявления (Application), код PlantUML*

```plantuml
@startuml
hide empty description
skinparam defaultFontName "Liberation Sans"
state "подано" as submitted : getResults()
state "допущено к конкурсу" as admitted : calculateTotalScore()
state "не допущено" as notAdmitted
state "ожидает ручного решения" as pending
state "зачислено" as enrolled
state "не зачислено" as notEnrolled

[*] --> submitted : registerApplicant(...)\n[срок подачи документов действует]
submitted --> admitted : isAdmitted(minScore)\n[сданы все экзамены, все баллы ≥ minScore]
submitted --> notAdmitted : isAdmitted(minScore)\n[есть балл < minScore]
admitted --> admitted : changeSpecialty(newSpecialty) /\nchangeBasis(newBasis)\n[срок зачисления не наступил]
admitted --> enrolled : conductCompetition(minScore)\n[проходит по баллам]
admitted --> notEnrolled : conductCompetition(minScore)\n[мест не хватило]
admitted --> pending : conductCompetition(minScore)\n[равенство баллов, профильного\nпредмета и среднего балла аттестата]
pending --> enrolled : enrollManually(application, reason)
pending --> enrolled : redistributePlaces(...)\n[места перераспределены]
pending --> notEnrolled : enrollManually(application, reason)\n[выбран другой абитуриент]
notAdmitted --> [*]
enrolled --> [*]
notEnrolled --> [*]
@enduml
```

*Шаг №6.2 Диаграмма состояний срока (Deadline), код PlantUML*

```plantuml
@startuml
hide empty description
skinparam defaultFontName "Liberation Sans"
state "запланирован" as planned : isActive(date) = false
state "действует" as active : isActive(date) = true
state "завершён" as finished : isActive(date) = false

[*] --> planned : setDeadline(type, startDate, endDate)
planned --> planned : setDeadline(type, startDate, endDate)\n[изменение границ срока]
planned --> active : isActive(date)\n[наступила startDate]
active --> active : setDeadline(type, startDate, endDate)\n[новая endDate позже текущей]
active --> finished : isActive(date)\n[наступила endDate]
finished --> [*]
@enduml
```
