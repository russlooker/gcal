connection: "calendar"

include: "test.base.lkml"

explore: find_me_inthe_api {
  hidden: yes
  extends: [test]
}

explore: test3 {
  extends: [test2]
}
