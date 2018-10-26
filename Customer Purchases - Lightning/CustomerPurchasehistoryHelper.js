({
	fetchProducts : function(component, event) {
        var action = component.get("c.getProducts");
        var actTwo = component.get("c.twoYears");
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
                var errors = res.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
            //last bracket for first call 
        });
        actTwo.setParams({"custnum": component.get("v.customer")});

            actTwo.setCallback(this, function(response){
                    var stateTwo = response.getState();
                    if(stateTwo === "SUCCESS"){
                        var callTwo = response.getReturnValue();
                        component.set("v.totalTwo", callTwo.length);
                        component.set("v.oldList", callTwo); 
                    } else if(stateTwo === "INCOMPLETE"){
                        console.log('Response is incomplete');
                    } else if(stateTwo === "ERROR"){
                        var eTwo = response.getError();
                            if(eTwo){
                                if (eTwo[0] && eTwo[0].message) {
                                    alert("Error message: " + 
                                                eTwo[0].message);
                                }
                            }else{
                                console.log('unknown erro'); 
                            }
                    }
            });
        $A.enqueueAction(action);
    },
})