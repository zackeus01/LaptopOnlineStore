function incrementValue(seri) {
    var input = document.getElementById("quantityInput" + seri);
    var hiddenInputElement = document.getElementById("quantityInputHidden");
    var value = parseInt(input.value);
    value += 1;
    input.value = value;
    hiddenInputElement.value = value;
}

function decrementValue(seri) {
    var input = document.getElementById("quantityInput" + seri);
    var hiddenInputElement = document.getElementById("quantityInputHidden");
    var value = parseInt(input.value);
    if (value > 1) {
        value -= 1;
    }
    input.value = value;
    hiddenInputElement.value = value;
}


function addToCart(seri) {
    // Get the necessary data from the form
    var quantity = document.getElementById("quantityInput" + seri).value;
    // Create a new XMLHttpRequest object
    var xhr = new XMLHttpRequest();
    // Set up the AJAX request
    xhr.open("POST", "cart", true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    // Define the callback function
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // Update the cart container with the response
            document.getElementById("cartContainer").innerHTML = xhr.responseText;
        }
    };
    // Send the AJAX request with the form data
    xhr.send("addToCart=true&seri=" + seri + "&quantity=" + quantity);
}


function submitReview() {
    var name = document.getElementById("nameInput").value.trim();
    var email = document.getElementById("emailInput").value.trim();
    var review = document.getElementById("reviewInput").value.trim();
    var rating = document.querySelector('input[name="rating"]:checked').value.trim();
    
    if (name=="" || email=="" || review=="" || rating=="" || rating==0) {
        document.getElementById("notification").textContent = "All fields must be filled.";
        document.getElementById("notification").style.display = "block";
    }
    else {
        var hiddenInputName = document.getElementById("nameInputHidden");
        hiddenInputName.value = name;
        var hiddenInputEmail = document.getElementById("emailInputHidden");
        hiddenInputEmail.value = email;
        var hiddenInputReview = document.getElementById("reviewInputHidden");
        hiddenInputReview.value = review;
        var hiddenInputRating = document.getElementById("ratingInputHidden");
        var rateValue = parseInt(rating);
        hiddenInputRating.value = rateValue;
    }
}
