({
        Search: function(component, event, helper) {
            var input = component.find('lookUp');
           //appears .focus() not working at this time there is a ticket in SF for it 
           //  input.focus();
            var isValueMissing = input.get('v.validity').valueMissing;
            // if value is missing show error message and focus on field
            if(isValueMissing) {
                input.showHelpMessageIfInvalid();
                input.focus();
            }else{
              // else call helper function 
                helper.fetchProducts(component, event);
                component.find("lookUp").set("v.value", '')
            }
        },
    })