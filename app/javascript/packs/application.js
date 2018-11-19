import "bootstrap";
import $ from 'jquery';
import {datetimepicker} from 'eonasdan-bootstrap-datetimepicker';
  console.log('hey in date time')
  let varo =  $('#datetimepicker')
  console.log( varo)
  $('#datetimepicker').datetimepicker({
    locale: 'fr',
    sideBySide: true,
    format: "DD-MM-YYYY h:mm A"
  });
  console.log(  $('#datetimepicker'))
