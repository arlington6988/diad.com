/**
 * Created by jjones2 on 7/17/16.
 */


var paymentForm = new SqPaymentForm({
    applicationId: 'sandbox-sq0idp-YIDR4JFlIVezYhbQtF3eSA', // <-- Add your application ID here
    inputClass: 'sq-input',
    inputStyles: [
        {
            fontSize: '30px'
        },
    ],
    cardNumber: {
        elementId: 'sq-card-number',
        placeholder: '•••• •••• •••• ••••'
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
        elementId: 'sq-postal-code'
    },
    callbacks: {
        cardNonceResponseReceived: function(errors, nonce, cardData) {
            if (errors) {
                // handle errors
                errors.forEach(function(error) { console.log(error.message); });
            } else {
                // handle nonce
                //alert('Nonce received! ' + nonce + ' ' + JSON.stringify(cardData));
                // Assign the value of the nonce to a hidden form element
                var nonceField = document.getElementById("card_nonce");
                nonceField.value = nonce;
                // Submit the form
                console.log('Nonce received!');
                // console.log(nonce);
                document.getElementById("number").submit();
            }
        },
        unsupportedBrowserDetected: function() {
            // Alert the buyer that their browser is not supported
        },
        inputEventReceived: function(inputEvent) {
            switch (inputEvent.eventType) {
                case 'focusClassAdded':
                    // Handle as desired
                    break;
                case 'focusClassRemoved':
                    // Handle as desired
                    break;
                case 'errorClassAdded':
                    // Handle as desired
                    break;
                case 'errorClassRemoved':
                    // Handle as desired
                    break;
                case 'cardBrandChanged':
                    // Handle as desired
                    break;
                case 'postalCodeChanged':
                    // Handle as desired
                    break;
            }
        }
    }
});

function requestCardNonce() {
    paymentForm.requestCardNonce();

}