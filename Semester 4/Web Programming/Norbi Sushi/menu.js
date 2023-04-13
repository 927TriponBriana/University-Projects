$(document).ready(function(){
	const database = firebase.database();
	const beforeQuery = database.ref('menu/');

	/***************
		Notifications
	****************/
	const notification = (message) =>
	{
		if(message == 'fillall')
		{
			$('.fillall').fadeIn(1000);
			setTimeout(function(){
				$('.fillall').fadeOut(1000);
			},3500);
		}

		if(message == 'inserted successfully')
		{
			$('.inserted').fadeIn(1000);
			setTimeout(function(){
				$('.inserted').fadeOut(1000);
			},3500);
		}

		if(message == 'updated')
		{
			$('.updated').fadeIn(1000);
			setTimeout(function(){
				$('.updated').fadeOut(1000);
			},3500);
		}
	}

	/***************
		Adding new dishes
	****************/
	$('[name=submit').click(function(e){
		e.preventDefault();

		const category = $('[name=category]').val(),
				 title = $('[name=title]').val(),
				 price = $('[name=price]').val(),
				 image = $('[name=image]').val().slice(12),
				 newid = beforeQuery.push();
				 // console.log(category);
				 // console.log(title);
				 // console.log(price);
				 // console.log(image);

				  if(!title || !price || !image)
				  {
				  	notification('fillall');
				  }
				  else
				  {
				  	newid.set({
				  		category : category,
				  		title : title,
				  		price : price,
				  		image : "img/"+image
				  	},
				  	function(error){
				  		if(!error)
				  		{
				  			notification("inserted successfully");
				  			$('[name=title]').val("");
				  			$('[name=price]').val("");
				  			$('[name=image]').val("");

				  		}
				  		else
				  		{
				  			console.log('Not saved');
				  		}
				  	});
				  }

	});

});
