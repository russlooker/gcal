 view: events {
   sql_table_name: public.events_d ;;

  dimension: gcal_distinct_event_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.gcal_distinct_event_id ;;
  }

  dimension: calendar_etl_instance_id {
    type: number
    sql: ${TABLE}.calendar_etl_instance_id ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_time ;;
  }

  dimension: guests_can_invite_others {
    type: yesno
    sql: ${TABLE}.guests_can_invite_others ;;
  }

  dimension: hangout_link {
    hidden: yes
    type: string
    sql: ${TABLE}.hangout_link ;;
  }

  dimension: htmllink {
    hidden: yes
    type: string
    sql: ${TABLE}.htmllink ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: meeting_type {
    type: string
    sql: ${TABLE}.meeting_type ;;
    case: {
      when: {
        sql: ${TABLE}.meeting_type = 'check-in' ;;
        label: "Check In"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'codev' ;;
        label: "Co Dev"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'demo' ;;
        label: "Demo"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'kickoff' ;;
        label: "Kickoff"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'looker internal' ;;
        label: "looker internal"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'next-steps' ;;
        label: "Next-Steps"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'OOO' ;;
        label: "OOO"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'other/external' ;;
        label: "other/external"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'Personal' ;;
        label: "Personal"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'pricing' ;;
        label: "pricing"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'training' ;;
        label: "training"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'visit' ;;
        label: "visit"
      }
      when: {
        sql: ${TABLE}.meeting_type = 'onboarding' ;;
        label: "onboarding"
      }
  }

  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }

  dimension: private_copy {
    type: yesno
    sql: ${TABLE}.private_copy ;;
  }

  dimension: pulled_from {
#     hidden: yes
    type: string
    sql: ${TABLE}.pulled_from ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      minute30,
      week_of_year,
      day_of_week,
      day_of_month,
      day_of_week_index,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  dimension: duration_row_level {
    type: number
    hidden: yes
    sql: datediff(mins,${start_raw}, ${end_raw}) ;;
    value_format: "# \"Mins\""
  }

  dimension:  duration_tier {
    type: tier
    tiers: [0,30,45,60,90,120,240]
    sql: ${duration_row_level};;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: title {
    type: string
    sql:
      CASE
        WHEN ${is_external} OR ${meeting_type} = 'OOO' THEN ${TABLE}.title
        ELSE '*****'
      END
          ;;
    link: {
      label: "Go to Calendar Event"
      url: "{{htmllink._value}}"
      icon_url: "http://2.bp.blogspot.com/-i4O7-MJJJmQ/VFkuulhnkQI/AAAAAAAB_ig/1H6mmPz4Dy8/s1600/calendar-logo.png"
    }
    link: {
      label: "Go to Google Hangout"
      url: "{{hangout_link._value}}"
      icon_url: "http://www.brandsoftheworld.com/sites/default/files/styles/logo-thumbnail/public/112013/hangouts_0.png?itok=reYr0Z3x"
    }

    link: {
      label: "View Opportunity"
      url: "https://looker.my.salesforce.com/{{opportunity_id._value}}"
      icon_url: "http://www.salesforce.com/favicon.ico"
    }
  }

  dimension: transparency {
    type: string
    sql: ${TABLE}.transparency ;;
  }

  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated ;;
  }

  dimension: visibility {
    type: string
    sql: ${TABLE}.visibility ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}.creator ;;
  }

  dimension: is_external {
    type: yesno
    sql:
      CASE
        WHEN ${meeting_type} = 'OOO' THEN 0
        WHEN ${meeting_type} = 'Personal' THEN 0
        WHEN ${meeting_type} = 'looker internal' THEN 0
        ELSE 1
      END
      ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw, minute15,hour,hour_of_day,date,week,month,quarter,year]
    sql: ${TABLE}.created ;;
  }

  measure: total_duration {
    type: sum
    sql: ${duration_row_level}*1.0/60;;
    value_format: "#0.00 \"Hrs\""
    drill_fields: [company_name, title, meeting_type,start_time, end_time, total_duration]
    filters: {
      field: status
      value: "-cancelled"
    }
    filters: {
      field: title
      value: "-%CANCELLED%,-%CANCELED%"
    }
  }

  measure: total_external_duration {
    type: sum
    sql: ${duration_row_level}*1.0/60;;
    value_format: "#0.00 \"Hrs\""
    drill_fields: [company_name, title, meeting_type, start_time, end_time, total_duration]
    filters: {
      #exclude formal cancellations
      field: status
      value: "-cancelled"
    }
    filters: {
      field: is_external
      value: "yes"
    }
    filters: {
      #exclude informal cancellations
      field: title
      value: "-%CANCELLED%,-%CANCELED%"
    }
    filters: {
      #exclude all day events
      field: duration_row_level
      value: "<1440"
    }
  }


  measure: event_count {
    type: count_distinct
    sql: ${gcal_distinct_event_id} ;;
    drill_fields: [gcal_distinct_event_id, company_name, title, meeting_type, start_time, end_time, total_duration]
  }
}
