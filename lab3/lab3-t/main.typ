#import "conf.typ" : conf
// #import "conf.typ" : turn-on-first-line-indentation
#show: conf.with(
  title: [Тема работы],
  type: "nir",
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
  )
)
