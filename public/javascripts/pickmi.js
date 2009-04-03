FiveBooks = function(options) {
	this.options = options;
	this.books = [];
	this.books_title = [];
	this.last_clicked=1;
	this.initAll();
}

FiveBooks.prototype.cellClicked = function(id) {
	if (this.last_clicked && this.last_clicked != id)
		document.getElementById('td' + this.last_clicked).removeClassName('selected')
	document.getElementById('td' + id).addClassName('selected');
	this.last_clicked = id
	
	if (this.books_title[id])
		document.getElementById('dsearch').setValue(this.books_title[id])
	else
		document.getElementById('dsearch').setValue('')

	document.getElementById('dsearch').focus();
	
}

FiveBooks.prototype.cellOver = function (id) {
	document.getElementById('td' + id).addClassName('hover');
}

FiveBooks.prototype.cellOut = function (id) {
	document.getElementById('td' + id).removeClassName('hover');
}

FiveBooks.prototype.addBook = function(book_id, title) {

	old_book_id =  this.books[this.last_clicked]
	this.loadBook(book_id, title, this.last_clicked);

	var ajax = new Ajax(); 
	var queryParams = { 
		'book_id': book_id,
		'book_old_id': old_book_id
	}
	ajax.responseType = Ajax.FBML;
	ajax.post(this.options.callback_url + 'books/select_remote', queryParams );
}

FiveBooks.prototype.initAll = function() {

	for(i=1;i<=5;i=i+1)
	{
		this.books[i]=null;
	}
}

FiveBooks.prototype.getSize = function() {

	size = 0;
	for(i=1;i<=5;i=i+1)
	{
		if (this.books[i] != null)
			size = size + 1;
	}
	return size;
}

FiveBooks.prototype.nextCell = function() {
	for(i=1;i<=5;i=i+1)
	{
		if (this.books[i] == null) {
			this.cellClicked(i);
			return true;
		}
	}
	
	if(this.last_clicked < 5) this.cellClicked(this.last_clicked + 1 )
	return true;
}

FiveBooks.prototype.loadBook = function(book_id, title, indice) {

	this.books[indice]=book_id;
	this.books_title[indice]=title;

	var ajax = new Ajax();
	ajax.responseType = Ajax.FBML;
	//ajax.ondone = this.onajaxdone.bind(this);
	ajax.indice = indice
	ajax.ondone = function (data) {
		if (this.indice) {
			document.getElementById('td'+ this.indice).setInnerFBML(data);
			suggestr.cleanup();
		}
	}
	
	ajax.post(this.options.callback_url + 'books/' + book_id + '/describe');
	
	if (this.getSize() == 5)
		document.getElementById('publish_proposition').setStyle('display', 'block');
	else
		document.getElementById('publish_proposition').setStyle('display', 'none');
}

FiveBooks.prototype.onFinish = function() {

	var ajax = new Ajax(); 
	var queryParams = { 
		'book_id1': this.books[1], 'book_id2': this.books[2], 
		'book_id3': this.books[3], 'book_id4': this.books[4], 'book_id5': this.books[5] 
	};

	ajax.responseType = Ajax.FBML;
	ajax.requireLogin = 0;    
	ajax.ondone = function(data) {}
	ajax.post(this.options.callback_url + 'books/select_remote', queryParams );
}
