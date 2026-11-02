#import "conf.typ" : conf
// #import "conf.typ" : turn-on-first-line-indentation
#show: conf.with(
  title: [Тема работы],
  type: "otchet",
  info: (
      author: (
        name: [Гожевой Анастасии Дмитриевны],
        faculty: [КНиИТ],
        group: "451",
        sex: "female"
      ),
      inspector: (
        degree: "доцент, к. ф.-м. н.",
        name: "С. В. Миронов"
      )
  ),
  settings: (
    title_page: (
      enabled: true
    ),
    contents_page: (
      enabled: true
    )
  ),
)

#include "content/01_task.typ"
#include "content/variant.typ"
#include "content/step1.typ"
#include "content/step2.typ"
#include "content/step3.typ"
#include "content/step4.typ"
#include "content/step5.typ"
#include "content/step6.typ"
#include "content/step7.typ"



