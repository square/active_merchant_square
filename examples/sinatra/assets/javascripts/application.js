//= require_tree .
//= require_directory .
var paymentForm;
var getPaymentForm = function(applicationId) {
  paymentForm = new SqPaymentForm({
    applicationId: applicationId,
    inputClass: 'sq-input',
    inputStyles: [
        {
          fontSize: '14px',
          padding: '7px 12px',
          backgroundColor: "transparent"
        }
      ],
    cardNumber: {
      elementId: 'sq-card-number',
      placeholder: '0000 0000 0000 0000'
    },
    cvv: {
      elementId: 'sq-cvv',
      placeholder: 'CVV'
    },
    expirationDate: {
      elementId: 'sq-expiration-date',
      placeholder: 'MM/YY'
    },
    postalCode: {
      elementId: 'sq-postal-code',
      placeholder: '94110'
    },
    callbacks: {
      cardNonceResponseReceived: function(errors, nonce, cardData) {
        if (errors){
          var error_html = ""
          for (var i =0; i < errors.length; i++){
            error_html += "<li> " + errors[i].message + " </li>";
          }
          document.getElementById("card-errors").innerHTML = error_html;
          document.getElementById('submit').disabled = false;
        }else{
          document.getElementById("card-errors").innerHTML = "";
          chargeCardWithNonce(nonce);
        }
      },
      unsupportedBrowserDetected: function() {
        // Alert the buyer
      }
    }
  });
  return paymentForm;
};

var paymentFormSubmit = function(){
  console.log('submit clicked');
  // document.getElementById('submit').disabled = true;
  paymentForm.requestCardNonce();
  return false;
}

var errorTypeMapping = {
	'invalid_number': 'Card number was not matched by processor',
    'invalid_expiry_date': 'Expiry date does not match correct formatting',
    'invalid_cvc': 'Security codes does not match correct format (3-4 digits)',
    'expired_card': 'Card number is expired',
    'incorrect_cvc': 'Security code was not matched by the processor',
    'incorrect_zip': 'Zip code is not in correct format',
    'incorrect_address': 'Billing address info was not matched by the processor',
    'incorrect_pin': 'Card PIN is incorrect',
    'card_declined': 'Card number declined by processor',
    'processing_error': 'Processor error',
    'call_issuer': 'Transaction requires voice authentication, call issuer',
    'pickup_card': 'Issuer requests that you pickup the card from merchant',
    'test_mode_live_card': 'Card was declined. Request was in test mode, but used a non test card.'
}

var mapErrorType = function(error) {
	return errorTypeMapping[error] || 'unknown error';
}

var chargeCardWithNonce = function(nonce) {
  var product_id = document.getElementById('product_id').value;
  var name = document.getElementById('name').value;
  var email = document.getElementById('email').value;
  var street_address_1 = document.getElementById('street_address_1').value;
  var street_address_2 = document.getElementById('street_address_2').value;
  var city = document.getElementById('city').value;
  var state = document.getElementById('state').value;
  var zip = document.getElementById('zip').value;

  var http = new XMLHttpRequest();
  var url = "/charges";
  var params = "product_id=" + product_id
  +"&name=" + name
  +"&email=" + email
  + "&nonce=" + nonce
  + "&street_address_1=" + street_address_1
  + "&street_address_2=" + street_address_2
  + "&city=" + city
  + "&state=" + state
  + "&zip=" + zip;

  http.open("POST", url, true);

  //Send the proper header information along with the request
  http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  http.setRequestHeader("X-CSRF-Token", "<%= form_authenticity_token %>");

  http.onreadystatechange = function() {//Call a function when the state changes.
      if(http.readyState == 4 && http.status == 200) {
        var data = JSON.parse(http.responseText)
        if (data.status == 200) {
          document.getElementById("successNotification").style.display = "block";
          document.getElementById("payment-form").style.display = "none";
          window.scrollTo(0, 0);
        } else if (data.status == 400) {
          var error_html = "<li> " + mapErrorType(data.error_type) + " </li>";
          document.getElementById("card-errors").innerHTML = error_html;
          document.getElementById('submit').disabled = false;
        }
      }
  }
  http.send(params);
}
