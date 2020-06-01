
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("select2")
require("styles")
require("chartkick")
require("chart.js")
require("scripts")


import $ from 'jquery'
window.$ = $

// seewtalert2
import Swal from 'sweetalert2/dist/sweetalert2.js'
import 'sweetalert2/src/sweetalert2.scss'
window.Swal = Swal

import "bootstrap";
import "controllers";
import '@fortawesome/fontawesome-free/js/all';
import '@fortawesome/fontawesome-free/css/all.min.css';
import 'tempusdominus-bootstrap-4';
import 'tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.min.css';
import "select2/dist/css/select2.min.css";
import "select2/dist/js/select2.full.min.js";

import 'Vue/init.js'
import { TaskInput } from 'Vue/components/todo';
Vue.component('input', TaskInput)

const images = require.context('../images');
const imagePath = name => images(name, true);