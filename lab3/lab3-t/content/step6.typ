= #underline[*ШАГ №6 В некоторых случаях объекты предметной области обладают собственным поведением. Для описания их поведения следует составить диаграмму состояний. Важно показать состояния, события и условия переходов.*]

*Шаг №6.1 Диаграмма состояний для класса Documents (Заявление)*

#image("/assets/lab3-Documents.png", width: 80%)
/*
```plantuml
@startuml
skinparam linetype ortho
skinparam shadowing false
skinparam state {
  BackgroundColor #FEFECE
  BorderColor #A80036
  ArrowColor #333333
}

[*] --> SUBMITTED : Создание заявления\n(абитуриент подал документы)
SUBMITTED --> ACCEPTED : Проверка документов\n[сроки соблюдены и данные верны]
SUBMITTED --> WITHDRAWN : Отзыв документов\n[до начала конкурса]

ACCEPTED --> WITHDRAWN : Отзыв документов\n[до срока зачисления]
ACCEPTED --> TRANSFERRED : Перевод на другую\nспециальность (UC10)\n[совпадают экзамены]

ACCEPTED --> ENROLLED : Успешное прохождение\nконкурса (UC7)\n[проходит по баллам]
TRANSFERRED --> ENROLLED : Успешное прохождение\nконкурса на новой\nспециальности

WITHDRAWN --> [*]
ENROLLED --> [*]

@enduml
```
*/


*Шаг №6.2 Диаграмма состояний для класса Competition (Конкурс)*

#image("/assets/lab3-Competition.png", width: 80%)

/*
```
@startuml
skinparam linetype ortho
skinparam shadowing false
skinparam state {
  BackgroundColor #FEFECE
  BorderColor #A80036
  ArrowColor #333333
}

[*] --> PREPARING : Начало конкурса\n(наступил срок зачисления)

PREPARING --> RANKING : Сбор заявлений\nзавершён
PREPARING --> RANKING : Нет участников\n(недобор = все места)

RANKING --> TIE_RESOLVING : Обнаружено равенство\nбаллов на границе мест
TIE_RESOLVING --> RANKING : Автоматический тай-брейк\n(профильный предмет / аттестат)
TIE_RESOLVING --> MANUAL_WAIT : Тай-брейк не сработал\n(нужно ручное решение)

MANUAL_WAIT --> RANKING : Секретарь ПК\nвручную зачислил (UC4)\n[указана причина]

RANKING --> COMPLETED : Все места заполнены\nили участники закончились
COMPLETED --> [*]

@enduml
```
*/


*Шаг №6.3 Диаграмма состояний для класса Abiturient (Абитуриент)*

#image("/assets/lab3-Abiturient.png", width: 80%)


/*
```
@startuml
skinparam linetype ortho
skinparam shadowing false
skinparam state {
  BackgroundColor #FEFECE
  BorderColor #A80036
  ArrowColor #333333
}

[*] --> REGISTERED : Регистрация\n(Технический секретарь, UC1)

REGISTERED --> APPLIED : Подача документов\nна специальность (UC6)
APPLIED --> EXAMINED : Внесение результатов\nвсех экзаменов (UC14)\n[все экзамены сданы]

EXAMINED --> ENROLLED : Успешное прохождение\nконкурса (UC7)
EXAMINED --> NOT_ENROLLED : Не проходит по конкурсу\n(баллов не хватило)

NOT_ENROLLED --> APPLIED : Перевод на другую\nспециальность (UC10)\n[совпадают экзамены]
NOT_ENROLLED --> APPLIED : Перевод на внебюджет\n(UC10)\n[есть места]

ENROLLED --> [*]
NOT_ENROLLED --> [*]

@enduml
```
*/