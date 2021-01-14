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
