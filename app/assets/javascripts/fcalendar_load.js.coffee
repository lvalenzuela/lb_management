$(document).ready ->
  if $("#calendar").length > 0
    $("#calendar").fullCalendar
      header:
        left: "prev,next today"
        center: "title"
        right: "month,agendaWeek,agendaDay"

      buttonText: #This is to add icons to the visible buttons
        prev: "<span class='fa fa-caret-left'></span>"
        next: "<span class='fa fa-caret-right'></span>"
        today: "today"
        month: "month"
        week: "week"
        day: "day"

      
      #Random default events
      events: gon.events
      editable: false
      droppable: false

  return