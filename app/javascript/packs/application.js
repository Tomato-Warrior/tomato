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

import "bootstrap";
import "./script/main.scss";
import "./script/_library.scss";
import "controllers";
import '@fortawesome/fontawesome-free/js/all';

import 'sweetalert2/src/sweetalert2.scss'


import '@fortawesome/fontawesome-free/css/all.min.css';
import 'tempusdominus-bootstrap-4';
import 'tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.min.css';
import "select2/dist/css/select2.min.css";

import "select2/dist/js/select2.full.min.js";
import './home/home.scss'


