 view: events {
   derived_table: {
    distribution_style: even
    sortkeys: ["start_time"]
    sql_trigger_value:
      SELECT
        max(calendar_etl_instance_id)
      FROM
        public.EVENTS_D
    ;;
    sql:
          SELECT
            *
          FROM
            public.events_d
    ;;
   }


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
      year,
      minute15
    ]
    sql: ${TABLE}.end_time ;;
    convert_tz: no
  }

  dimension: guests_can_invite_others {
    type: yesno
    sql: ${TABLE}.guests_can_invite_others ;;
    hidden: yes
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
    hidden: yes
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

  dimension: account_id {
    hidden: yes
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: private_copy {
    hidden: yes
    type: yesno
    sql: ${TABLE}.private_copy ;;
  }

  dimension: pulled_from {
    hidden: yes
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
      minute15,
      week_of_year,
      day_of_week,
      day_of_month,
      day_of_week_index,
      date,
      week,
      month,
      month_num,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
    convert_tz: yes
  }

  dimension: is_before_dtd {
    description: "Filter this on 'yes' to compare to same period in previous days"
    group_label: "Start Date"
    type: yesno
    sql:
      (
        (
          EXTRACT(HOUR FROM ${start_raw}) < EXTRACT(HOUR FROM CURRENT_TIMESTAMP)
        )
        OR
        (
          EXTRACT(HOUR FROM ${start_raw}) = EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AND
          EXTRACT(MINUTE FROM ${start_raw}) < EXTRACT(MINUTE FROM CURRENT_TIMESTAMP)
        )
      );;
  }

  dimension: is_before_wtd {
    description: "Filter this on 'yes' to compare to same period in previous weeks"
    group_label: "Start Date"
    type: yesno
    sql:
      (EXTRACT(DOW FROM ${start_raw}) < EXTRACT(DOW FROM CURRENT_TIMESTAMP)
        OR
        (
          EXTRACT(DOW FROM ${start_raw}) = EXTRACT(DOW FROM CURRENT_TIMESTAMP) AND
          EXTRACT(HOUR FROM ${start_raw}) < EXTRACT(HOUR FROM CURRENT_TIMESTAMP)
        )
        OR
        (
          EXTRACT(DOW FROM ${start_raw}) = EXTRACT(DOW FROM CURRENT_TIMESTAMP) AND
          EXTRACT(HOUR FROM ${start_raw}) <= EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AND
          EXTRACT(MINUTE FROM ${start_raw}) < EXTRACT(MINUTE FROM CURRENT_TIMESTAMP)
        )
      );;
  }

  dimension: is_before_mtd {
    description: "Filter this on 'yes' to compare to same period in previous months"
    group_label: "Start Date"
    type: yesno
    sql:
      (EXTRACT(DAY FROM ${start_raw}) < EXTRACT(DAY FROM CURRENT_TIMESTAMP)
        OR
        (
          EXTRACT(DAY FROM ${start_raw}) = EXTRACT(DAY FROM CURRENT_TIMESTAMP) AND
          EXTRACT(HOUR FROM ${start_raw}) < EXTRACT(HOUR FROM CURRENT_TIMESTAMP)
        )
        OR
        (
          EXTRACT(DAY FROM ${start_raw}) = EXTRACT(DAY FROM CURRENT_TIMESTAMP) AND
          EXTRACT(HOUR FROM ${start_raw}) <= EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AND
          EXTRACT(MINUTE FROM ${start_raw}) < EXTRACT(MINUTE FROM CURRENT_TIMESTAMP)
        )
      );;
  }

  dimension: is_before_ytd {
    description: "Filter this on 'yes' to compare to same period in previous years"
    group_label: "Start Date"
    type: yesno
    sql:
      (EXTRACT(DOY FROM ${start_raw}) < EXTRACT(DOY FROM CURRENT_TIMESTAMP)
        OR
        (
          EXTRACT(DOY FROM ${start_raw}) = EXTRACT(DOY FROM CURRENT_TIMESTAMP) AND
          EXTRACT(HOUR FROM ${start_raw}) < EXTRACT(HOUR FROM CURRENT_TIMESTAMP)
        )
        OR
        (
          EXTRACT(DOY FROM ${start_raw}) = EXTRACT(DOY FROM CURRENT_TIMESTAMP) AND
          EXTRACT(HOUR FROM ${start_raw}) <= EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AND
          EXTRACT(MINUTE FROM ${start_raw}) < EXTRACT(MINUTE FROM CURRENT_TIMESTAMP)
        )
      );;
  }



  dimension: duration_row_level {
    type: number
    hidden: yes
    sql: datediff(mins,${start_raw}, ${end_raw}) ;;
    value_format: "# \"Mins\""
  }

  dimension: scheduled_lead_time {
    type: number
#     hidden: yes
    description: "How long between the invite sent and the meeting start?"
    sql: (datediff(mins,${created_raw}, ${start_raw})*1.0/60) ;;
    value_format: "# \"Mins\""
  }

  dimension: lead_time_tiers {
    type: tier
    tiers: [0,60,120,240,480,960,1920,3840,7680,15360,30720]
    sql:  ${scheduled_lead_time};;
  }


  measure: avg_sched_lead_time {
    type: average
    sql:  ${scheduled_lead_time}*1.0;;
    drill_fields: [company_name, title, meeting_type, start_time, end_time, total_duration, attendees.count]
    value_format: "#0.00 \"Hrs\""
  }




  dimension:  duration_tier {
    type: tier
    tiers: [0,30,45,60,90,120,240]
    value_format: "# \"Mins\""
    sql: ${duration_row_level};;
    style: integer
  }


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
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
      label: "View Account"
      url: "https://looker.my.salesforce.com/{{account_id._value}}"
      icon_url: "http://www.salesforce.com/favicon.ico"
    }
  }

  dimension: transparency {
    hidden: yes
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
    hidden: yes
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
    drill_fields: [company_name, title, meeting_type,start_time, end_time, total_duration, attendees.count]
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
    drill_fields: [company_name, title, meeting_type, start_time, end_time, total_duration, attendees.count]
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
    drill_fields: [company_name, title, meeting_type, created_minute15, start_time, end_time, total_duration, attendees.count]
  }
}




########## OBFUSCATION CODE ##########

  # dimension: is_obfuscated {
  #   type: string
  #   sql: CASE
  #           WHEN ${is_external} THEN 'No'
  #           WHEN ${permission_filter.event_id} is not null THEN 'No'
  #           ELSE 'Yes'
  #         END ;;
  # }
#OR (${permission_filter.event_id} is not null)
  # dimension: obfuscated_title {
  #   type: string
  #   sql:
  #   CASE
  #     WHEN ${is_obfuscated} = 'No' THEN ${TABLE}.title
  #     ELSE MD5(${TABLE}.title || 'salt')
  #     END
  #     ;;
  #   link: {
  #     label: "Go to Calendar Event"
  #     url: "{{htmllink._value}}"
  #     icon_url: "http://2.bp.blogspot.com/-i4O7-MJJJmQ/VFkuulhnkQI/AAAAAAAB_ig/1H6mmPz4Dy8/s1600/calendar-logo.png"
  #   }
  #   link: {
  #     label: "Go to Google Hangout"
  #     url: "{{hangout_link._value}}"
  #     icon_url: "http://www.brandsoftheworld.com/sites/default/files/styles/logo-thumbnail/public/112013/hangouts_0.png?itok=reYr0Z3x"
  #   }

  #   link: {
  #     label: "View Account"
  #     url: "https://looker.my.salesforce.com/{{account_id._value}}"
  #     icon_url: "http://www.salesforce.com/favicon.ico"
  #   }
  #   html:
  #   {% if is_obfuscated._value == 'Yes' %}
  #     ##### Obfuscated Data #####
  #   {% else %}
  #     {{linked_value}}
  #   {% endif %}
  #   ;;

  # }
