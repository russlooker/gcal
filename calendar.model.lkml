connection: "calendar"

# include all the views
include: "*.view"

# include all the dashboards
#include: "*.dashboard"


explore: events {
  join: attendees {
    type: left_outer
    sql_on: ${events.id} = ${attendees.event_id} ;;
    relationship: one_to_many
  }
  # join: permission_filter {
  #   type: left_outer
  #   sql_on:  ${events.id} = ${permission_filter.event_id} ;;
  #   relationship: one_to_one
  # }
  join: attendees_filter {
    type: inner
    sql_on:  ${events.id} = ${attendees_filter.event_id} ;;
    relationship: one_to_many
  }

}


explore: ts {
  join: events {
    type: left_outer
    sql_on:  ${ts.ts_minute15} = ${events.start_minute15};;
    relationship: one_to_many
  }
  join: attendees {
    type: left_outer
    sql_on: ${events.id} = ${attendees.event_id} ;;
    relationship: one_to_many
  }
  # Uncomment for obfuscation
  # join: permission_filter {
  #   type: left_outer
  #   sql_on:  ${events.id} = ${permission_filter.event_id} ;;
  #   relationship: one_to_one
  # }
  join: attendees_filter {
    type: inner
    sql_on:  ${events.id} = ${attendees_filter.event_id} ;;
    relationship: one_to_many
  }
}
