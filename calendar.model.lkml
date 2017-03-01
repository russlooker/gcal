connection: "calendar"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

# explore: attendees {
#   join: events {
#     type: left_outer
#     sql_on: ${attendees.event_id} = ${events.gcal_distinct_event_id} ;;
#     relationship: many_to_one
#   }
# }


explore: events {
  join: attendees {
    type: left_outer
    sql_on: ${events.id} = ${attendees.event_id} ;;
    relationship: one_to_many
  }
  join: attendees_filter {
    type: inner
    sql_on:  ${events.id} = ${attendees_filter.event_id} ;;
    relationship: one_to_many
  }
}
