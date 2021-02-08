import moment from 'moment'
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
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
    // themeSystem: 'bootstrap',
    // height: 734,
    // aspectRatio: 1.35,
    nowIndicator: true,
    navLinks: true,
    selectable: true,
    selectHelper: true,
    editable: true,
    eventLimit: true,
    dayMaxEventRows: 4,
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
      $.getScript('/activities/new', () => {
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
        failure: function() {
          alert('there was an error while fetching events!');
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
    }, /*
    eventClick: (info) => {
      info.jsEvent.preventDefault();

      $.getScript(`events/${info.event.id}/edit`, () => {
        $('#start_date_field').val(moment(info.event.start).format('YYYY/MM/DD HH:mm'));
        $('#end_date_field').val(moment(info.event.end).format('YYYY/MM/DD HH:mm'));
      });

      calendar.unselect()
      $('#modal-window').on('hide.bs.modal', () => {
        calendar.render()
        calendar.getEventSources().forEach(eventSource => eventSource.refetch())
      });
    }, */
  });

  calendar.render();
  window.calendar = calendar
});