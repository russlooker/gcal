connection: "calendar"

include: "test.base.lkml"

explore: test2 {
  hidden: yes
  extends: [test]
}

explore: test3 {
  extends: [test2]
}
