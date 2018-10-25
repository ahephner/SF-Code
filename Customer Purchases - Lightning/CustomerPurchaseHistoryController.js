({
	getProductList : function(component, event, helper) {
        var input = component.find('lookUp').get('v.value');
        //console.log("before " + input);
        //if i stringify it wont run through apex class
        //var input = JSON.stringify(input);
        //console.log(input);
        helper.fetchProducts(component, input);
	}
})