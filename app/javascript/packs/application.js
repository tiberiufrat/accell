// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Core libraries
import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// jQuery (as a read only property so browser extensions can't clobber it)
const jquery = require("jquery")
const descriptor = { value: jquery, writable: false, configurable: false }
Object.defineProperties(window, { $: descriptor, jQuery: descriptor })

const Cookies = require('js-cookie')
global.Cookies = require('js-cookie')

require('datatables.net');
require('datatables.net-select')
require('datatables.net-buttons')
require('datatables.net-buttons/js/buttons.html5.js')
require('datatables.net-buttons/js/buttons.print.js')
require('datatables.net-bs4')

window.pdfmake = require("pdfmake/build/pdfmake")
window.pdfFonts = require("pdfmake/build/vfs_fonts")
window.pdfMake.vfs = window.pdfFonts.pdfMake.vfs;

require('controllers') // import controllers, which also imports summernote_controller

require('select2')

require('bootstrap-datepicker')

require('@popperjs/core')

window.iziToast = require("izitoast")

window.moment = require("moment")

window.reloadWithTurbolinks = require('packs/custom_head.js')

require("jquery.nicescroll")
require("chart.js")
require("Chart.extension.js")
require("jquery-scrollLock.min.js")
require("jquery.scrollbar.min.js")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Datepicker
$.fn.datepicker.dates['ro'] = {
    days: ["Duminică", "Luni", "Marți", "Miercuri", "Joi", "Vineri", "Sâmbătă"],
    daysShort: ["Dum", "Lun", "Mar", "Mie", "Joi", "Vin", "Sâm"],
    daysMin: ["Du", "Lu", "Ma", "Mi", "Jo", "Vi", "Sâ"],
    months: ["Ianuarie", "Februarie", "Martie", "Aprilie", "Mai", "Iunie", "Iulie", "August", "Septembrie", "Octombrie", "Noiembrie", "Decembrie"],
    monthsShort: ["Ian", "Feb", "Mar", "Apr", "Mai", "Iun", "Iul", "Aug", "Sep", "Oct", "Noi", "Dec"],
    today: "Astăzi",
    clear: "Șterge",
    format: "dd-mm-yyyy",
    titleFormat: "MM yyyy",
    weekStart: 1
  };
