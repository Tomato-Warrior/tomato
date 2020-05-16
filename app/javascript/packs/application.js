// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("projects")
require("tictacs")
require("counters")
require("select2")


import $ from 'jquery'
window.$ = $
// sewwtalert2
import Swal from 'sweetalert2/dist/sweetalert2.js'
window.Swal = Swal
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "bootstrap";
import "./script/main.scss";
import "./script/_library.scss";
import "controllers";
import '@fortawesome/fontawesome-free/js/all';
import "select2/dist/css/select2.min.css"
import "select2/dist/js/select2.full.min.js"
import 'sweetalert2/src/sweetalert2.scss'
import './home/home.scss'
