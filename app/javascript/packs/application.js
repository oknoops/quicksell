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
import { loadDynamicBannerText } from '../components/banner';

if(document.querySelector('.banner')) { loadDynamicBannerText(); }

function scrollLastMessageIntoView() {
   console.log('zer') 
  const messages = document.querySelectorAll('.message');
  const lastMessage = messages[messages.length - 1];

  if (lastMessage !== undefined) {
    lastMessage.scrollIntoView();
  }
}
if(document.querySelector('.create-message')){ scrollLastMessageIntoView();}

