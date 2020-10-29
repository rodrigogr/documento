'use strict'
$('body').css('zoom', $(window).width() / 1920);
window.onresize = (event) => $('body').css('zoom', $(window).width() / 1920);
$(document).ajaxSend(() => $('.loader').show());
$(document).ajaxStop(() => $('.loader').hide());
$(document).on('show.bs.modal', '.modal', () => setTimeout(() => {
	let myObjs = Array.from($('select,input'));
	for (var i = 0; i < myObjs.length; i++) {
		$(myObjs[i]).focus();
		if ($(myObjs[i]).is(":focus")) break;
	}
	$('.modal-body').scrollTop(0);
}, 500))