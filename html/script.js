$(function() {
    $(".container").hide();
	$(".notification").hide();
    window.onload = (e) => {
        /* 'links' the js with the Nui message from main.lua */
        window.addEventListener('message', (event) => {
            var item = event.data;
            if (item !== undefined && item.type === "ui") {
                /* if the display is true, it will show */
                if (item.display === true) {
					$(".container").fadeIn();
					$(".notification").fadeOut();
                     /* if the display is false, it will hide */
                } else {
					$(".container").fadeOut();
					$(".notification").fadeIn();
                }
            }
			if (item.notificationdisplay !== undefined && item.notificationdisplay === true) {
				$(".notification").fadeIn();
			} else {
				$(".notification").fadeOut();
			}
        });

        document.onkeyup = function (data) {
             if(data.which == 27) {
                $(".container").fadeOut();
				$(".notification").fadeIn();
                $.post('http://5e-lspdform/exit', JSON.stringify({}));
                return;
            }
        };  
    };
});

function stringLength(str) {
	return str.length;
}

function submitForm(event) {
	event.preventDefault();
	let fullName = document.getElementById("full-name").value;
	let age = document.getElementById("age").value;
	let phoneNumber = document.getElementById("phone-number").value;
	let experience = document.getElementById("experience").value;
	let lookingToDo = document.getElementById("looking-to-do").value;

	let fullNameError = document.getElementById("full-name-error");
	let ageError = document.getElementById("age-error");
	let phoneNumberError = document.getElementById("phone-number-error");
	let experienceError = document.getElementById("experience-error");
	let lookingToDoError = document.getElementById("looking-to-do-error");

	let valid = true;

	if (fullName === "") {
		fullNameError.style.display = "block";
		valid = false;
	} else {
		if (stringLength(fullName) > 4) {
			fullNameError.style.display = "none";
		} else {
			fullNameError.style.display = "block";
			valid = false;
		}
	}

	if (age === "") {
		ageError.style.display = "block";
		valid = false;
	} else {
		ageError.style.display = "none";
	}

	if (phoneNumber === "" || isNaN(phoneNumber)) {
		phoneNumberError.style.display = "block";
		valid = false;
	} else {
		phoneNumberError.style.display = "none";
	}

	if (experience === "") {
		experienceError.style.display = "block";
		valid = false;
	} else {
		if (stringLength(experience) > 4) {
			experienceError.style.display = "none";
		} else {
			experienceError.style.display = "block";
			valid = false;
		}
	}

	if (lookingToDo === "") {
		lookingToDoError.style.display = "block";
		valid = false;
	} else {
		if (stringLength(lookingToDo) > 4) {
			lookingToDoError.style.display = "none";
		} else {
			lookingToDoError.style.display = "block";
			valid = false;
		}
	}

	if (valid) {
		let data = {
			fullName,
			age,
			phoneNumber,
			experience,
			lookingToDo,
		}
		document.getElementById("lspd-form").reset();
		$.post('http://5e-lspdform/join', JSON.stringify({data}));
		$(".container").fadeOut()
		$(".notification").fadeIn();
	}
}