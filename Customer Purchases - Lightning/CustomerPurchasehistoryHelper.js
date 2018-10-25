({
	fetchProducts : function(component, input) {
        var action = component.get("c.getProducts");
        
        console.log('in helper ' + input)
            action.setParams({"custnum": input});
         
        action.setCallback(this, function(res){
            var state = res.getState();
            if(state == 'SUCCESS'){
                console.log(state)
                var productList = res.getReturnValue(); 
               console.log(productList); 
            } else{
               var error = res.getError();
               console.log("Error => " + error);
                component.find('lookUp').set('v.value', '');
            }
        })
        $A.enqueueAction(action);

	}
})