view: attendees {
#   sql_table_name: public.attendees_f ;;
  derived_table: {
    distribution_style: even
    sortkeys: ["email"]
    sql_trigger_value:
        SELECT max(e.calendar_etl_instance_id) FROM ${events.SQL_TABLE_NAME} e
    ;;
    sql:
    SELECT * FROM public.attendees_d
      ;;
  }


  dimension: accepted {
    type: string
    sql: ${TABLE}.accepted ;;
    html:
      {% if value == 'declined' %}
        <div style="color: black; background-color: #dc7350; margin: 0; border-radius: 5px; text-align:center">{{ value }}</div>
      {% elsif value == 'tentative' %}
        <div style="color: black; background-color: #e9b404; margin: 0; border-radius: 5px; text-align:center">{{ value }}</div>
      {% elsif value == 'accepted' %}
        <div style="color: black; background-color: #49cec1; margin: 0; border-radius: 5px; text-align:center">{{ value }}</div>
      {% else %}
        <div style="color: black; background-color: #929292; margin: 0; border-radius: 5px; text-align:center">{{ value }}</div>
      {% endif %}

    ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.comment ;;
  }

  dimension: email {
    type: string
    #skip_drill_filter: yes
    sql: ${TABLE}.email ;;
  }

  dimension: event_id {
    type: number
    hidden: yes
    sql: ${TABLE}.event_id ;;
  }

  dimension:  pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${event_id} || ${email} ;;
  }

  dimension: is_external {
    type: yesno
    sql: ${email} !~* '.*looker.*' ;;
  }

  dimension: optional {
    type: yesno
    sql: ${TABLE}.optional ;;
  }

  dimension: organizer {
    type: yesno
    sql: ${TABLE}.organizer ;;
  }

  dimension: resource {
    type: yesno
    sql: ${TABLE}.resource ;;
  }

  dimension: room_name {
    type: string
    sql:
    CASE
        WHEN ${email} = 'looker.com_2d38303039343130382d333539@resource.calendar.google.com' THEN 'SC-4-26th Avenue'
        WHEN ${email} = 'looker.com_2d36383232323434343336@resource.calendar.google.com' THEN 'SC-4-Davenport'
        WHEN ${email} = 'looker.com_2d37303636333231312d383933@resource.calendar.google.com' THEN 'SC-4-Harbor Mouth'
        WHEN ${email} = 'looker.com_2d3634313237363433313530@resource.calendar.google.com' THEN 'SC-4-Scotts Creek'
        WHEN ${email} = 'looker.com_36313836373531382d393531@resource.calendar.google.com' THEN 'SC-4-Sharks'
        WHEN ${email} = 'looker.com_38353932373137372d393531@resource.calendar.google.com' THEN 'SC-4-Steamers Lane'
        WHEN ${email} = 'looker.com_2d35343039343539372d3536@resource.calendar.google.com' THEN 'SC-4-The Hook'
        WHEN ${email} = 'looker.com_3537333935313439353432@resource.calendar.google.com' THEN 'SC-4-Wadell Creek'
        WHEN ${email} = 'looker.com_38313833313637342d343338@resource.calendar.google.com' THEN 'SC-4-Mitchels Cove'
        WHEN ${email} = 'looker.com_2d3639343131353636363839@resource.calendar.google.com' THEN 'SC-4-Pleasure Point'
        WHEN ${email} = 'looker.com_35343737383739393939@resource.calendar.google.com' THEN 'SC-3-EMT-(5)'
        WHEN ${email} = 'looker.com_35383736373635302d3131@resource.calendar.google.com' THEN 'SC-3-Enchanted Loop-(10)'
        WHEN ${email} = 'looker.com_3433353932313539323931@resource.calendar.google.com' THEN 'SC-3-Felix the Cat-(4)'
        WHEN ${email} = 'looker.com_37303237393936362d383738@resource.calendar.google.com' THEN 'SC-3-Flow Trail-(8 VC)'
        WHEN ${email} = 'looker.com_3633333633373236343331@resource.calendar.google.com' THEN 'SC-3-Lockem Up-(5)'
        WHEN ${email} = 'looker.com_31343431343531392d383438@resource.calendar.google.com' THEN 'SC-3-Long Meadow-(50 VC)'
        WHEN ${email} = 'looker.com_2d37373435393436343832@resource.calendar.google.com' THEN 'SC-3-Magic Carpet-(5)'
        WHEN ${email} = 'looker.com_32343634393631362d313238@resource.calendar.google.com' THEN 'SC-3-Mailboxes-(8 VC)'
        WHEN ${email} = 'looker.com_2d35303736343939372d393236@resource.calendar.google.com' THEN 'SC-3-Star Wars-(8 VC)'
        WHEN ${email} = 'looker.com_2d3836343331323938393437@resource.calendar.google.com' THEN 'SC-3-Wally World-(5)'
        WHEN ${email} = 'looker.com_2d39343033333136322d383730@resource.calendar.google.com' THEN 'NYC-Blob Dylan-(4)'
        WHEN ${email} = 'looker.com_2d313439353032362d393237@resource.calendar.google.com' THEN 'NYC-Dashboard Confessional-(4)'
        WHEN ${email} = 'looker.com_2d3137333733393836343938@resource.calendar.google.com' THEN 'NYC-Johnny Cache-(4)'
        WHEN ${email} = 'looker.com_2d31303135303636302d343538@resource.calendar.google.com' THEN 'NYC-Notorious PDT-(16)'
        WHEN ${email} = 'looker.com_2d36373933363738342d393632@resource.calendar.google.com' THEN 'SF-Big Conference Room'
        ELSE NULL
        END
    ;;
  }

  measure: count {
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [email, room_name, accepted, comment,optional,organizer,resource, is_external]
    filters: {
      field: email
      value: "%"
    }
  }
  measure: accepted_count {
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [email, room_name, accepted, comment,optional,organizer,resource, is_external]
    filters: {
      field: email
      value: "%"
    }
    filters: {
      field: accepted
      value: "accepted"
    }

  }
  measure: declined_count {
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [email, room_name, accepted, comment,optional,organizer,resource, is_external]
    filters: {
      field: email
      value: "%"
    }
    filters: {
      field: accepted
      value: "declined"
    }
  }
  measure: needs_action_count {
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [email, room_name, accepted, comment,optional,organizer,resource, is_external]
    filters: {
      field: email
      value: "%"
    }
    filters: {
      field: accepted
      value: "needsAction"
    }
  }
  measure: tentative_count {
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [email, room_name, accepted, comment,optional,organizer,resource, is_external]
    filters: {
      field: email
      value: "%"
    }
    filters: {
      field: accepted
      value: "tentative"
    }
  }

  measure: accept_rate {
    type: number
    sql: ${accepted_count}*1.0 / nullif(${count},0) ;;
    value_format_name: percent_1
  }
  measure: decline_rate {
    type: number
    sql: ${declined_count}*1.0 / nullif(${count},0) ;;
    value_format_name: percent_1
  }


}
