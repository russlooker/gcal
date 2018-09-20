connection: "calendar"

include: "calendar.events.view.lkml"

datagroup: test1 {
  max_cache_age: "24 hours"
}

persist_with: test1

explore: events {
}
