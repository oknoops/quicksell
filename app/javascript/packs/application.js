import "bootstrap";
import $ from 'jquery';
import {datetimepicker} from 'eonasdan-bootstrap-datetimepicker';
  let varo =  $('#datetimepicker')
  $('#datetimepicker').datetimepicker({
    locale: 'fr',
    sideBySide: true,
    format: "DD-MM-YYYY h:mm A"
  });
import { loadDynamicBannerText } from '../components/banner';

if(document.querySelector('.banner')) { loadDynamicBannerText(); }

function scrollLastMessageIntoView() {
  const messages = document.querySelectorAll('.message');
  const lastMessage = messages[messages.length - 1];

  if (lastMessage !== undefined) {
    lastMessage.scrollIntoView();
  }
}
if(document.querySelector('.create-message')){ scrollLastMessageIntoView();}

