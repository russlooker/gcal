view: attendees_filter {
  derived_table: {
    sql:
      SELECT
        DISTINCT
          event_id
        FROM
          ${attendees.SQL_TABLE_NAME} AD
        WHERE
          1=1
          AND {% condition attendees_filter.email %} AD.email {% endcondition %}
          -- AND {% condition attendees.email %} AD.email {% endcondition %}
      UNION ALL
        SELECT
          DISTINCT
          id
        FROM
          ${events.SQL_TABLE_NAME} EDO
        WHERE
          1=1
          AND {% condition attendees_filter.email %} EDO.pulled_from {% endcondition %}
          -- AND {% condition attendees.email %} EDO.pulled_from {% endcondition %}

      ;;
  }

  dimension:  event_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.event_id ;;
  }

  filter: email {
    label: "Email Of Person There"
    description: "Allows you to filter to the events in which someone was present without impacting the attendee list"
    type: string
    suggest_dimension: attendees.email
    view_label: "Events"
  }

}



view: permission_filter {
  derived_table: {
    sql:
              SELECT
                DISTINCT
                  event_id
                FROM
                  ${attendees.SQL_TABLE_NAME} AD
                WHERE
                  1=1
                  AND  AD.email = '{{ _user_attributes["email"] }}'
                  -- AND {% condition attendees.email %} AD.email {% endcondition %}
              UNION ALL
                SELECT
                  DISTINCT
                  id
                FROM
                  ${events.SQL_TABLE_NAME} EDO
                WHERE
                  1=1
                  AND EDO.pulled_from = '{{ _user_attributes["email"] }}'
                  -- AND {% condition attendees.email %} EDO.pulled_from {% endcondition %}

              ;;
  }

  dimension:  event_id {
    type: number
#         hidden: yes
    primary_key: yes
    sql: ${TABLE}.event_id ;;
  }

}
