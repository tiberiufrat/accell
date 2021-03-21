import moment from 'moment'
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin, { Draggable } from '@fullcalendar/interaction';
import adaptivePlugin from '@fullcalendar/adaptive'
import roLocale from '@fullcalendar/core/locales/ro';

$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, timeGridPlugin, interactionPlugin, adaptivePlugin ],
    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
    locale: roLocale,
    headerToolbar: false,
    contentHeight: 'auto',
    height: 'auto',
    nowIndicator: true,
    navLinks: true,
    selectable: true,
    selectHelper: true,
    editable: true,
    droppable: true,
    eventLimit: true,
    eventTimeFormat: {
      hour: 'numeric',
      minute: '2-digit',
      meridiem: false
    },
    slotDuration: '00:05:00',
    slotMinTime: '07:00:00',
    slotMaxTime: '20:00:00',
    allDaySlot: false,
    weekends: false,
    textEscape: false,

    datesSet: (info) => {
      localStorage.setItem("fcDefaultView", info.view.type);
      localStorage.setItem("fcStartDate", moment(info.view.currentStart).format());
      document.getElementById('fc-card-title').innerText = info.view.title;
    },

    initialView: (localStorage.getItem("fcDefaultView") != null ? localStorage.getItem("fcDefaultView") : "dayGridMonth"),
    initialDate: (localStorage.getItem("fcStartDate") != null ? localStorage.getItem("fcStartDate") : moment(new Date).format()),

    select: (info) => {
      let activityable_gid_from_url = new URLSearchParams(window.location.search).get('activityable_gid')
      
      $.getScript(`/activities/new?activityable_gid=${ activityable_gid_from_url }`, () => {
        $('#start_date_field').val(moment(info.start).format('YYYY-MM-DDTHH:mm'));
        $('#end_date_field').val(moment(info.end).format('YYYY-MM-DDTHH:mm'));
      });

      calendar.unselect()
      $('#modal-window').on('hide.bs.modal', () => {
        calendar.render()
        calendar.getEventSources().forEach(eventSource => eventSource.refetch())
      });
    },

    eventSources: [
      {
        url: '/activities.json',
        method: 'GET',
        extraParams: function() {
          let urlParams = new URLSearchParams(window.location.search)
          if(urlParams.has('activityable_gid')) {
            return { activityable_gid: urlParams.get('activityable_gid') }
          } else {
            return null;
          }
        },
        failure: function(e) {
          alert('there was an error while fetching events!');
          console.log(e)
        },
      }
    ],

    eventClassNames: (arg) => {
      if (arg.event.backgroundColor) {
        let colorLength = arg.event.backgroundColor.length - 1
        let colorName = arg.event.backgroundColor.substring(6, colorLength)
        return ['bg-' + colorName]
      } else {
        return ['bg-default']
      }
    },

    eventDidMount: function (info) {
      if(info.view.type !== 'dayGridMonth') {
        let insert = document.createElement('span')
        insert.innerHTML = '<hr class="my-2">';
        // Append owner
        if(info.event.extendedProps.activityableName) {
          insert.innerHTML += '<i class="far fa-fw fa-building"></i> ' + info.event.extendedProps.activityableName + '<br>'
        }
        // Append staff
        if(info.event.extendedProps.coordinatorName) {
          insert.innerHTML += '<i class="far fa-fw fa-user-tie"></i> ' + info.event.extendedProps.coordinatorName + '<br>'
        }
        // Append subject
        // if(info.event.extendedProps.subjectName) {
        //   insert.innerHTML += '<b>Subject:</b> ' + info.event.extendedProps.subjectName + '<br>'
        // }
        // Prepend icon to title if it exists
        if (info.event.extendedProps.subjectIcon) {
          let subjectIcon = document.createElement('i')
          subjectIcon.classList.add('far', 'fa-fw', 'mr-1', info.event.extendedProps.subjectIcon.split(' ')[1])
          info.el.querySelector('.fc-event-title').prepend(subjectIcon)
        }

        info.el.querySelector('.fc-event-title').append(insert);
      }
    },
    
    // Moving event
    eventDrop: (info) => {

      if (info.event._def.recurringDef === null) {
        var eventData = {
          activity: {
            start: info.event.start,
            end: info.event.end,
            all_day: info.event.allDay,
          },
        };
      } else {
        var eventData = {
          activity: {
            start_time: moment(info.event.start).format('HH:mm'),
            end_time: moment(info.event.end).format('HH:mm'),
            all_day: info.event.allDay,
            days_of_week: [moment(info.event.start).format('e')]
          }
        }
      }
      
      $.ajax({
        url: info.event.url,
        data: eventData,
        type: 'PATCH',
        dataType: 'json',
        success: function(json) {
          calendar.render()
          calendar.getEventSources().forEach(eventSource => eventSource.refetch())
        }
      });
    },

    eventResize: (info) => {
      if (info.event._def.recurringDef === null) {
        var eventData = {
          activity: {
            start: info.event.start,
            end: info.event.end,
            all_day: info.event.allDay,
          },
        };
      } else {
        var eventData = {
          activity: {
            start_time: moment(info.event.start).format('HH:mm'),
            end_time: moment(info.event.end).format('HH:mm'),
            all_day: info.event.allDay,
            days_of_week: [moment(info.event.start).format('e')]
          }
        }
      }

      $.ajax({
        url: info.event.url,
        data: eventData,
        type: 'PATCH',
        dataType: 'json',
        success: function(json) {
          calendar.render()
          calendar.getEventSources().forEach(eventSource => eventSource.refetch())
        }
      });
    },
    eventClick: (info) => {
      info.jsEvent.preventDefault();

      $.getScript(`activities/${info.event.id}/edit`, () => {
        if(info.event._def.recurringDef) {
          $('#recurring_check').prop( "checked", true )
          $('#recurring_fields').show()
          $('#normal_fields').hide()
        } else {
          $('#start_date_field').val(moment(info.event.start).format('YYYY-MM-DDTHH:mm'));
          $('#end_date_field').val(moment(info.event.end).format('YYYY-MM-DDTHH:mm'));
        }

        $('#activity_activityable_gid').val(info.event.extendedProps.activityable_gid)
      });

      calendar.unselect()

      $('#modal-window').on('hide.bs.modal', () => {
        if(!info.event.id) {
          reloadWithTurbolinks()
        }
        calendar.render()
        calendar.getEventSources().forEach(eventSource => eventSource.refetch())
      });
    },

    // Dropping external event
    eventReceive: (info) => {
      let activityable_gid_from_url = new URLSearchParams(window.location.search).get('activityable_gid')

      let eventData = {
        activity: {
          start: info.event.startStr,
          end: info.event.endStr,
          title: info.event.title,
          subject_id: info.event.extendedProps.subjectId,
          activityable_gid: activityable_gid_from_url,
        }
      }

      $.ajax({
        url: '/activities',
        data: eventData,
        type: 'POST',
        dataType: 'json',
        success: function(json) {
          info.event.setProp('url', json.url)
          info.event.setExtendedProp('id', json.id)
          info.event.remove() // remove the dragged event
          calendar.render() // rerender and display the event from the database 
          calendar.getEventSources().forEach(eventSource => eventSource.refetch())
        }
      });
    },

    // Start dragging event
    eventDragStart: (info) => {
      $('#calendar').addClass('cursor-grabbing');
    },

    // End dragging event
    eventDragStop: (info) => {
      $('#calendar').removeClass('cursor-grabbing');
    },
  });

  calendar.render();

  // Make calendar a global object
  window.calendar = calendar

  let containerEl = document.getElementById('subject-list')

  new Draggable(containerEl, {
    itemSelector: '.subject-draggable'
  });
});