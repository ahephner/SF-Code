({
	fetchProducts : function(component, event) {
        var action = component.get("c.getProducts");
        console.log(component.get("v.customer"));
        
            action.setParams({"custnum": component.get("v.customer")});
         
        action.setCallback(this, function(res){
            var state = res.getState();
            if(state === 'SUCCESS'){
                console.log(state)
                var call = res.getReturnValue(); 
               console.log(call);
                        //set atribute lengthn
                        if(call.length == 0){
                            component.set("v.message", true);
                        }else{
                            component.set("v.message", false);
                        }
                component.set("v.totals", call.length);
                component.set("v.productList", call);
}else if (state === "INCOMPLETE") {
                alert('Response is Incompleted');
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
})